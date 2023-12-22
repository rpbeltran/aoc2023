use std::fs::File;
use std::io::{prelude::*, BufReader};
use std::path::Path;
use std::collections::HashMap;
use itertools::Itertools;

mod regions;
use regions::*;

fn lines_from_file(filename: impl AsRef<Path>) -> Vec<String> {
    let file = File::open(filename).expect("no such file");
    BufReader::new(file).lines().map(|l| l.expect("Could not parse line")).collect()
}

fn corners1() -> Vec<(i64, i64)> {
    let mut points : Vec<(i64, i64)> = Vec::new();
    let (mut x, mut y): (i64, i64) = (1,1);
    for line in lines_from_file("input.txt") {
        points.push((x, y));
        let parts = line.split(" ").collect_vec();
        let dist = parts[1].parse::<i64>().unwrap();
        match parts[0] {
            "U" => {
                y -= dist;
            }
            "D" => {
                y += dist;
            }
            "L" => {
                x -= dist;
            }
            "R" => {
                x += dist;
            }
            _  => {}
        }
    }
    points
}

fn corners2() -> Vec<(i64, i64)> {
    let mut points : Vec<(i64, i64)> = Vec::new();
    let (mut x, mut y): (i64, i64) = (1,1);
    for line in lines_from_file("input.txt") {
        points.push((x, y));
        let hex = line.split(" ").collect_vec()[2];
        let dist = i64::from_str_radix(&hex[2..7], 16).unwrap();
        let dir = hex.chars().nth(7).unwrap();
        match dir {
            '3' => {
                y -= dist;
            }
            '1' => {
                y += dist;
            }
            '2' => {
                x -= dist;
            }
            '0' => {
                x += dist;
            }
            _  => {}
        }
    }
    points
}


fn get_area(corners:  Vec<(i64, i64)>) -> i64 {
    let mut points_x: HashMap<i64, Vec<i64>> = HashMap::new();
    let mut points_y: HashMap<i64, Vec<i64>> = HashMap::new();

    for (x, y) in corners {
        if points_x.contains_key(&x) {
            points_x.get_mut(&x).unwrap().push(y);
        } 
        else {
            points_x.insert(x, Vec::from([y]));
        }
        if points_y.contains_key(&y) {
            points_y.get_mut(&y).unwrap().push(x);
        } 
        else {
            points_y.insert(y, Vec::from([x]));
        }
    }

    let mut vert_line_tops: HashMap<i64, Vec<i64>> = HashMap::new(); // y -> xs
    for (x, mut ys) in points_x.into_iter().sorted() {
        ys.sort_unstable();
        let mut tops: Vec<i64> = Vec::new();
        for (a,_) in get_alternating(&get_regions(&ys)) {
            tops.push(a);
            if vert_line_tops.contains_key(&a) {
                vert_line_tops.get_mut(&a).unwrap().push(x);
            } else {
                vert_line_tops.insert(a, Vec::from([x]));
            }   
        }   
    }

    let mut total_area = 0;
    let mut inside_regions: Vec<(i64, i64)> = Vec::new();

    let mut inside_width = 0;
    let mut previous_y   = 0;

    for (y, mut xs) in points_y.into_iter().sorted() {
        xs.sort_unstable();
        total_area += inside_width * (y - previous_y - 1);
        let crossings = get_alternating(&regions::get_regions(&xs));
        let new_inside_region = &regions::exclude_regions(&crossings, &inside_regions);
        let mut new_outside_region = regions::normalize(&intersect_regions(&inside_regions, &crossings));
        if vert_line_tops.contains_key(&y) {
            let vert_top_regions = vert_line_tops
                .get(&y)
                .unwrap()
                .into_iter()
                .map(|x| (*x,*x))
                .into_iter()
                .collect_vec();
            new_outside_region = exclude_regions(&new_outside_region, &vert_top_regions);
        }
        let next_inside_regions = normalize(&exclude_regions(&union_regions(&inside_regions, &new_inside_region), &new_outside_region));
        total_area += get_total_width(&union_regions(&inside_regions, &next_inside_regions));
        inside_regions = next_inside_regions;
        inside_width = get_total_width(&inside_regions);
        previous_y = y;
    }
    total_area + inside_width
}


fn main() {
    println!("Part 1: {}", get_area(corners1()));
    println!("Part 2: {}", get_area(corners2()));
}

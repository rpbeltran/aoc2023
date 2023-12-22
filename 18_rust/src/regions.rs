use std::iter::zip;
use itertools::Itertools;


pub fn get_regions(xs: &Vec<i64>) -> Vec<(i64, i64)> {
    zip(xs, xs.iter().skip(1))
        .map(|(a,b)| (*a, *b))
        .collect_vec()
}

pub fn get_alternating(regions: &Vec<(i64, i64)>) -> Vec<(i64, i64)> {
    regions
        .iter()
        .enumerate()
        .filter( |(i, _)| i % 2 == 0)
        .map(|(_, r)| r.clone())
        .collect_vec()
}

pub fn get_total_width(regions: &Vec<(i64, i64)>) -> i64 {
    regions
        .iter()
        .fold(0, |acc, (a,b)| acc + b - a + 1)
}

pub fn intersect_one_region(original: &Vec<(i64, i64)>, region: &(i64, i64)) -> Vec<(i64, i64)> {
    let (a, b) = region;
    let mut intersection: Vec<(i64, i64)> = Vec::new();
    for (i, j) in original {
        let u = std::cmp::max(*a, *i);
        let v = std::cmp::min(*b, *j);
        if u <= v {
            intersection.push((u, v));
        }
        if i > b { // Assume sorted
            break
        }
    }
    intersection
}

pub fn intersect_regions(first: &Vec<(i64, i64)>, second: &Vec<(i64, i64)>) -> Vec<(i64, i64)> {
    let mut intersection: Vec<(i64, i64)> = Vec::new();
    for region in first {
        intersection.append(&mut intersect_one_region(second, region))
    }
    intersection
}

pub fn union_regions(first: &Vec<(i64, i64)>, second: &Vec<(i64, i64)>) -> Vec<(i64, i64)> {
    let mut union = second.clone();
    union.append(&mut exclude_regions(first, second));
    union
        .into_iter()
        .sorted()
        .clone()
        .collect_vec()
}

pub fn region_difference(original: &(i64, i64), minus: &(i64, i64)) -> Vec<(i64, i64)> {
    let (a,b) = original.clone();
    let (u,v) = minus.clone();
    let left_end = std::cmp::min(b, u-1);
    let right_start = std::cmp::max(a, v+1);
    let mut difference: Vec<(i64, i64)> = Vec::new();
    if a <= left_end {
        difference.push((a, left_end))
    }
    if right_start <= b {
        difference.push((right_start, b))
    }
    difference
}

pub fn difference_one_region(original: &Vec<(i64, i64)>, minus: &(i64, i64)) -> Vec<(i64, i64)> {
    let mut difference: Vec<(i64, i64)> = Vec::new();
    for orig in original {
        difference.append(&mut region_difference(orig, minus))
    }
    difference
}

pub fn exclude_regions(first: &Vec<(i64, i64)>, second: &Vec<(i64, i64)>) -> Vec<(i64, i64)> {
    let mut difference: Vec<(i64, i64)> = first.clone();
    for region in second {
        difference = difference_one_region(&difference, region);
    }
    difference
}

pub fn rm_spikes(regions: &Vec<(i64, i64)>) -> Vec<(i64, i64)> {
    regions.clone()
        .into_iter()
        .filter( |(a, b)| a != b)
        .collect_vec()
}

pub fn normalize(regions: &Vec<(i64, i64)>) -> Vec<(i64, i64)> {
    let mut normal: Vec<(i64, i64)> = Vec::new();
    let mut previous_region = (-99,-99);
    for region in regions {
        if previous_region.1 + 1 == region.0 {
            previous_region.1 = region.1;
        } else {
            normal.push(previous_region.clone());
            previous_region = *region;
        }
    }
    normal.push(previous_region.clone());
    rm_spikes(&normal)
}

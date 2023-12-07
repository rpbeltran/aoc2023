package main

import (
	"fmt"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func get_lines(path string) []string {
	dat, err := os.ReadFile(path)
	check(err)
	return strings.Split(string(dat), "\n")
}

func get_hand_strength(hand string) float64 {
	frequency := make(map[byte]int)
	for i := range hand {
		frequency[hand[i]] += 1
	}
	pairs := 0
	best := 0.0
	for k, v := range frequency {
		if k != 'J' {
			if v == 2 {
				pairs += 1
			}
			if float64(v) > best {
				best = math.Max(float64(v), best)
			}
		}
	}

	if frequency['J'] > 0 {
		if pairs == 2 && frequency['J'] == 1 {
			best += 0.5 // Full House
		}
		best += float64(frequency['J'])
	} else if (pairs > 0 && (best == 3)) || pairs == 2 {
		best += 0.5 // Full house or two pair
	}
	return best
}

func get_hand(hand string) []int {
	var hand_ints []int
	for _, card := range hand {
		hand_ints = append(hand_ints, strings.Index("J123456789TQKA", string(card)))
	}
	return hand_ints
}

type hand_data struct {
	orig     string
	hand     []int
	strength float64
	bet      int
}

func main() {
	lines := get_lines("input.txt")
	var hands []hand_data
	for _, line := range lines {
		parts := strings.Split(line, " ")
		bet, err := strconv.Atoi(parts[1])
		check(err)
		hands = append(hands, hand_data{
			orig:     parts[0],
			hand:     get_hand(parts[0]),
			strength: get_hand_strength(parts[0]),
			bet:      bet,
		})
	}
	sort.Slice(hands, func(a, b int) bool {
		if hands[a].strength != hands[b].strength {
			return hands[a].strength < hands[b].strength
		}
		for i := range hands[a].hand {
			if hands[a].hand[i] != hands[b].hand[i] {
				return hands[a].hand[i] < hands[b].hand[i]
			}
		}
		return true
	})

	sum := 0
	for i, hand := range hands {
		sum += (i + 1) * hand.bet
	}
	fmt.Println(sum)

}

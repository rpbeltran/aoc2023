import std.stdio, std.string;

import common;

void main()
{
    int total = 0;
    int[int] extra_cards;

    int line_num = 1;
    string line;
    auto file = File("input.txt");
    while ((line = file.readln()) !is null) {
        int current_cards = extra_cards.get(line_num, 0) + 1;
        foreach(i; line_num.. line_num + get_matches(line)) {
            extra_cards[i+1] = extra_cards.get(i+1, 0) + current_cards;
        }
        total += current_cards;
        line_num++;
    }
    writeln(total);
}

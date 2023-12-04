import std.algorithm, std.string, std.conv;

int get_matches(string line) {
    auto parts = line.split!(c => c == ':' || c == '|');
    auto wins = to!(int[]) (parts[1].split);
    auto hand = to!(int[]) (parts[2].split);

    int matches = 0;
    wins.each!((w) {
        matches += hand.count(w);
    });

    return matches;
}

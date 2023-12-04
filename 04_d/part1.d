import std.stdio, std.string;
import common;

void main()
{
    int sum = 0;
    auto file = File("input.txt");
    string line;
    while ((line = file.readln()) !is null)
        sum += (1 << get_matches(line)) / 2;
    writeln(sum);
}

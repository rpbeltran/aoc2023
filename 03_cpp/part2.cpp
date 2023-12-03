#include <iostream>

#include "common.h"

using namespace std;


int main(int argc, char* argv[]) {
    auto schema = get_schema(argv[1]);
    auto parts = get_parts(schema);
    auto symbols = get_symbols(schema);
    long sum = 0;
    for (auto symbol: symbols) {
        if (symbol.is_gear) {
            int ratio = 1;
            int part_count = 0;
            for (auto part: parts) {
                if (is_adjacent(part, symbol)) {
                    part_count += 1;
                    ratio *= part.value;
                }
            }
            if (part_count == 2) {
                sum += ratio;
            }
        }
    }
    cout << sum << endl;
}

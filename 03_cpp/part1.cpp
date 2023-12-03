#include <iostream>

#include "common.h"

using namespace std;

bool validate(const vector<Symbol> & symbols, const Part & part) {
    for (auto & symbol : symbols) {
        if (is_adjacent(part, symbol)) {
            return true;
        }
    }
    return false;
}

int main(int argc, char* argv[]) {
    auto schema = get_schema(argv[1]);
    auto parts = get_parts(schema);
    auto symbols = get_symbols(schema);
    long sum = 0;
    for (auto part: parts) {
        if (validate(symbols, part)) {
            sum += part.value;
        }
    }
    cout << sum << endl;
}

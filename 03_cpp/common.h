#include <fstream>
#include <iterator>
#include <sstream>
#include <string>
#include <vector>

using Schema = std::vector<std::string>;

Schema get_schema(const std::string & path) {
    Schema vec;
    std::ifstream file_in(path);
    std::string line;
    while (getline(file_in, line))
        vec.push_back(line);
    return vec;
}

struct Part {
    int row;
    int col_start;
    int col_end;
    int value;
};

std::vector<Part> get_parts(const Schema & schema) {
    std::vector<Part> parts;
    for (int row = 0; row < schema.size(); row++) {
        int width = schema[row].size();
        for (int i=0; i<width; i++) {
            if (isdigit(schema[row][i])) {
                int start = i;
                while (i<width && isdigit(schema[row][i])) {
                    i++;
                }
                int end = i-1;
                int value = stoi(schema[row].substr(start, end-start+1));
                parts.emplace_back(Part {
                    row, start, end, value
                });
            }
        }
    }
    return parts;
}

struct Symbol {
    int row;
    int col;
    bool is_gear;
};

std::vector<Symbol> get_symbols(const Schema & schema) {
    std::vector<Symbol> symbols;
    for (int row = 0; row < schema.size(); row++) {
        for (int col=0; col<schema[row].size(); col++) {
            char c = schema[row][col];
            if (!isdigit(c) && c != '.') {
                bool is_gear = (c == '*');
                symbols.emplace_back(Symbol {
                    row, col, is_gear
                });
            }
        }
    }
    return symbols;
}

bool is_adjacent(const Part & part, const Symbol & sym) {
    return (
        (abs(part.row - sym.row) <= 1) && 
        (sym.col >= part.col_start - 1) && 
        (sym.col <= part.col_end + 1)
    );
}

from typing import List, NamedTuple, Set, Tuple


class Moment (NamedTuple):
    x:  int;  y: int
    dx: int; dy: int

    def forward(self):
        return Moment(self.x + self.dx, self.y + self.dy, self.dx, self.dy)

    def split(self, splitter: str) -> Tuple["Moment", ...]:
        if splitter == '|' and self.dy == 0:
            return (
                Moment(self.x, self.y, 0, -1),
                Moment(self.x, self.y, 0,  1)
            )
        elif splitter == '-' and self.dx == 0:
            return (
                Moment(self.x, self.y, -1, 0),
                Moment(self.x, self.y,  1, 0)
            )
        return (self,)
    
    def bounce(self, mirror: str) -> "Moment":
        if mirror == "/":
            return Moment(self.x, self.y, -self.dy, -self.dx)
        return Moment(self.x, self.y, self.dy, self.dx)
    
    def in_bounds(self, w: int, h: int):
        return (0 <= self.x < w) and (0 <= self.y < h)

    def interact(self, item:str) -> Tuple["Moment", ...]:
        if item in '-|':
            return self.split(item)
        elif item in '\/':
            return (self.bounce(item),)
        return (self,)


def get_tour(course: List[str], start: Moment) -> Set[Tuple[int,int]]:
    starting_moments = set(start.interact(course[start.x][start.y]))
    explored: Set[Moment] = starting_moments.copy()
    frontier: Set[Moment] = starting_moments

    w = len(course)
    while len(frontier):
        new_frontier: Set[Moment] = set()
        for m_from in frontier:
            m_next = m_from.forward()
            if m_next.in_bounds(w, w):
                item = course[m_next.y][m_next.x]
                new_frontier.update(m_next.interact(item))
        frontier = new_frontier.difference(explored)
        explored.update(new_frontier)

    return len({(m.x, m.y) for m in explored})


with open("input.txt") as file:
    lines = [line.rstrip() for line in file ]

    # Part 1
    part_1 = get_tour(lines, Moment(0, 0, 1, 0))
    print( f"Part 1: {part_1}")

    # Part 2
    best = 0
    for i in range(w := len(lines)):
        best = max(
            (best,
            get_tour(lines, Moment( 0,   i,   1,   0)),
            get_tour(lines, Moment(w-1,  i,  -1,   0)),
            get_tour(lines, Moment( i,   0,   0,   1)),
            get_tour(lines, Moment( i,  w-1,  0,  -1)))
        )
    print( f"Part 2: {best}")



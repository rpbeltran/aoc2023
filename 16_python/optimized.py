from typing import List, NamedTuple, Set, Tuple

class Moment (NamedTuple):
    x:  int;  y: int
    dx: int; dy: int

    def forward(self):
        return Moment(self.x + self.dx, self.y + self.dy, self.dx, self.dy)
    
    def in_bounds(self, w: int, h: int):
        return (0 <= self.x < w) and (0 <= self.y < h)

    def interact(self, item:str) -> Tuple["Moment", ...]:
        if item == '.':
            return (self,)
        if item == '-':
            if self.dx == 0:
                return (
                    Moment(self.x, self.y, -1, 0),
                    Moment(self.x, self.y,  1, 0)
                )
            else:
                return (self,)
        if item == '|':
            if self.dy == 0:
                return (
                    Moment(self.x, self.y, 0, -1),
                    Moment(self.x, self.y, 0,  1)
                )
            else:
                return (self,)
        if item == '/':
            return (Moment(self.x, self.y, -self.dy, -self.dx),)
        return (Moment(self.x, self.y, self.dy, self.dx),)
        


def get_tour(course: List[str], start: Moment, explored, visited, i):
    frontier = start.interact(course[start.x][start.y])

    for s in frontier:
        explored[s.y][s.x][s.dx][s.dy] = i
        visited[s.y][s.x] = i

    w = len(course)
    count = len(frontier)
    while len(frontier):
        new_frontier = []
        for m_from in frontier:
            m_next = m_from.forward()
            if m_next.in_bounds(w, w):
                item = course[m_next.y][m_next.x]
                for n in m_next.interact(item):
                    if explored[n.y][n.x][n.dx][n.dy] != i:
                        explored[n.y][n.x][n.dx][n.dy] = i
                        if visited[n.y][n.x] != i:
                            visited[n.y][n.x] = i
                            count += 1
                        new_frontier.append(n)
        frontier = new_frontier

    return count


with open("input.txt") as file:
    lines = tuple(tuple(line.rstrip()) for line in file)

    w = len(lines)
    wm = w-1

    # explored[y,x,dx,dy] = last_seen
    explored = [[[[-1 for _ in range(3)] for _ in range(3)] for _ in range(w)] for _ in range(w)]
    # visited[y,x] = last_seen
    visited = [[-1 for _ in range(w)] for _ in range(w)]

    best = 0
    for i in range(w):
        best = max(
            (best, get_tour(lines, Moment( 0,  i,   1,   0), explored, visited, 4*i),
            get_tour(lines, Moment(wm,  i,  -1,   0), explored, visited, 4*i+1),
            get_tour(lines, Moment( i,   0,   0,   1), explored, visited, 4*i+2),
            get_tour(lines, Moment( i,  wm,  0,  -1), explored, visited, 4*i+3))
        )
    print(best)



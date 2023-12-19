CLS                              


' --- Parse costs from input file ---

OPEN "input.txt" FOR INPUT AS #1
width = 141

DIM SHARED cost (width, width) as Integer

FOR y=0 TO width-1
    FOR x=0 TO width-1
        INPUT #1, NUM
        cost(x,y) = NUM
    NEXT x
NEXT y


' --- Create a min-heap ---

TYPE HeapState
  size as LONG
  maxsize as LONG
  front as LONG
END TYPE

TYPE HeapEntry
  x AS Integer
  y AS Integer
  direction as Integer
  dtime as Integer
  priority AS LONG
END TYPE

DIM SHARED hindex (width, width, 4, 3) as LONG
DIM SHARED hstate as HeapState
DIM SHARED hdata ((width * width * 4 * 3) + 1) as HeapEntry
DIM SHARED hpopped as HeapEntry
CALL HInit (width)


' --- Prepopulate Distances and MinHeap ---

DIM dist (width, width, 4, 3) as LONG
DIM explored (width, width, 4, 3) as Integer
DIM entry as HeapEntry

infinity = 9999999&
FOR x=0 to (width-1)
    FOR y=0 to (width-1)
        FOR d=0 to 3
            FOR t=0 to 2
                dist(x, y, d, t) = infinity
            NEXT t
        NEXT d
    next y
next x

FOR d=0 TO 3
    dist(0,0,d,0) = 0
    entry.x = 0
    entry.y = 0
    entry.direction = d
    entry.dtime = 0
    entry.priority = 0
    CALL HInsert(entry)
next d


' --- Dijkstra's Algorithm ---

DIM SHARED neighborhood (3) as HeapEntry

while hstate.size > 0
    CALL HPop

    CALL GetNeighborhood(hpopped, width)

    FOR i=0 TO neighbor_count-1
        IF neighborhood(i).priority < dist(neighborhood(i).x, neighborhood(i).y, neighborhood(i).direction, neighborhood(i).dtime) THEN
            dist(neighborhood(i).x, neighborhood(i).y, neighborhood(i).direction, neighborhood(i).dtime) = neighborhood(i).priority
            IF explored(neighborhood(i).x, neighborhood(i).y, neighborhood(i).direction, neighborhood(i).dtime) = 0 THEN
                explored(neighborhood(i).x, neighborhood(i).y, neighborhood(i).direction, neighborhood(i).dtime) = 1
                CALL HInsert(neighborhood(i))
            ELSE
                CALL HReducePriority(neighborhood(i))
            END IF
        END IF
    NEXT i
WEND



best = infinity
FOR d=0 to 3
    FOR t=0 to 2
        IF dist(width-1, width-1, d, t) < best THEN
            best = dist(width-1, width-1, d, t)
        END IF
    NEXT t
NEXT d

PRINT best

END

' -- Get Neighbors --

SUB GetNeighborhood (entry as HeapEntry, width)
    SHARED neighbor_count
    neighbor_count = 0

    ' -- Directions --
    '  0) North
    '  1) East
    '  2) South
    '  3) West

    FOR TURN=3 TO 5
        ' 3 => left, 4 => straight, 5 => right 

        DIM neighbor AS HeapEntry

        neighbor.direction = (entry.direction + TURN) MOD 4
        neighbor.dtime = 0
        IF neighbor.direction = entry.direction THEN
            neighbor.dtime = entry.dtime + 1
        END IF

        neighbor.x = entry.x
        neighbor.y = entry.y
        IF neighbor.direction = 0 THEN
            neighbor.y = entry.y - 1
        ELSEIF neighbor.direction = 1 THEN
            neighbor.x = entry.x + 1
        ELSEIF neighbor.direction = 2 THEN
            neighbor.y = entry.y + 1
        ELSE
            neighbor.x = entry.x - 1
        END IF

        IF NOT (neighbor.x < 0 OR neighbor.x >= width OR neighbor.y < 0 OR neighbor.y >= width OR neighbor.dtime > 3) THEN
            neighbor.priority = entry.priority + cost(neighbor.x, neighbor.y)
            neighborhood(neighbor_count) = neighbor
            neighbor_count = neighbor_count + 1
        END IF

    NEXT TURN
END SUB


' --------------------------- Min Heap Implementation ---------------------------

SUB HInit (width)
    hstate.size = 0
    hstate.maxsize = width * width * 4 * 3
    hstate.front = 1
    FOR x=0 to (width-1)
        FOR y=0 to (width-1)
            FOR d=0 to 3
                FOR t=0 to 2
                    hindex(x, y, d, t) = -1
                NEXT t
            NEXT d
        next y
    next x
END SUB


FUNCTION HParent (index)
    HParent = index \ 2
END FUNCTION


FUNCTION HLeftChild (index)
    HLeftChild = index * 2
END FUNCTION


FUNCTION HRightChild (index)
    HRightChild = (index * 2) + 1
END FUNCTION


FUNCTION GetPriority(entry as HeapEntry)
    index = hindex(entry.x, entry.y, entry.direction, entry.dtime)
    IF index = -99 THEN 
        ' ALREADY POPPED => infinity
        GetPriority = 9999999&
    ELSE
        GetPriority = hdata(index).priority
    END IF
END FUNCTION


FUNCTION HIsLeaf (index)
    IF (index * 2) > hstate.size THEN
        HIsLeaf = 1
    ELSE
        HIsLeaf = 0
    END IF
END FUNCTION


SUB HSwap (a, b)
    SWAP hindex(hdata(a).x, hdata(a).y, hdata(a).direction, hdata(a).dtime), hindex(hdata(b).x, hdata(b).y, hdata(b).direction, hdata(b).dtime)
    SWAP hdata(a), hdata(b)
END SUB


SUB HMinHeapify (index)
    IF HIsLeaf(index) = 0 THEN
        left = HLeftChild(index)
        right = HRightChild(index)
        IF (hdata(index).priority > hdata(left).priority) OR (hdata(index).priority > hdata(right).priority) THEN
            smallest = index
            IF left <= hstate.size THEN 
                IF (hdata(left).priority < hdata(smallest).priority) THEN
                    smallest = left
                END IF
            END IF
            IF right <= hstate.size THEN 
                IF (hdata(right).priority < hdata(smallest).priority) THEN
                    smallest = right
                END IF
            END IF
            IF NOT index = smallest THEN
                CALL HSwap(index, smallest)
                CALL HMinHeapify(smallest)
            END IF

        END IF
    END IF
END SUB


SUB HInsert (entry as HeapEntry)
    hstate.size = hstate.size + 1
    hindex(entry.x, entry.y, entry.direction, entry.dtime) = hstate.size
    CALL HHelperPutAt(entry, hstate.size)
END SUB


SUB HHelperPutAt (entry as HeapEntry, index)
    hdata(index) = entry
    current = index
    parent = HParent(current)
    WHILE hdata(current).priority < hdata(parent).priority
        call HSwap(current, parent)
        current = parent
        parent = HParent(current)
    WEND
END SUB


SUB HPop ()
    hpopped = hdata(hstate.front)
    CALL HSwap (hstate.front, hstate.size)

    'These can be commented out for better performance, but may help with debugging
    hindex(hdata(hstate.size).x, hdata(hstate.size).y, hdata(hstate.size).direction, hdata(hstate.size).dtime) = -99
    hdata(hstate.size).x = -1
    hdata(hstate.size).y = -1
    hdata(hstate.size).direction = -1
    hdata(hstate.size).dtime = -1
    hdata(hstate.size).priority = 9999999
    hstate.size = hstate.size - 1

    CALL HMinHeapify(hstate.front)
END SUB


SUB HPrint ()
    FOR i=1 TO (hstate.size \ 2)
        PRINT hdata(i).priority;
        PRINT "  ->  ";
        PRINT hdata(HLeftChild(i)).priority;
        PRINT ", ";
        PRINT hdata(HRightChild(i)).priority
    NEXT i
END SUB


SUB HReducePriority (entry as HeapEntry)
    index = hindex(entry.x, entry.y, entry.direction, entry.dtime)
    CALL HHelperPutAt(entry, index)
END SUB

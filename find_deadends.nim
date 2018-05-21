import "iterator.nim"

var directions: array[4, array[2, int]] = [
    [1,  0],
    [-1, 0],
    [0,  1],
    [0,  -1],
]

proc find_deadends*(history: seq[seq[int]], ignore_x: int, ignore_y: int): int =
    var number_of_deadends = 0
    for y in 0->history.len() - 1:
        for x in 0->history[y].len() - 1:
            if (x == ignore_x and y == ignore_y or history[y][x] != 0): 
                continue

            var number_of_neighbors = 0
            for data in directions:
                if (x + data[0] == ignore_x and y + data[1] == ignore_y):
                    continue

                if (x + data[0] < 0 or y + data[1] < 0):
                    number_of_neighbors = number_of_neighbors + 1
                elif (x + data[0] >= history[0].len() or y + data[1] >= history.len()):
                    number_of_neighbors = number_of_neighbors + 1
                elif (history[y + data[1]][x + data[0]] != 0):
                    number_of_neighbors = number_of_neighbors + 1
            
            if (number_of_neighbors == 3):
                number_of_deadends = number_of_deadends + 1

    return number_of_deadends
import re, parseutils, times, os
import "iterator.nim"
import "order_data.nim"
import "extract_properties.nim"
import "construct_board.nim"
import "find_deadends.nim"
import "format.nim"


proc solve(vertex: array[2, int], history: seq[seq[int]], dx: int, dy: int, path: string): string =
    var both_are_zero = dx == 0 and dy == 0
    var history_clone = history
    var delta = 0

    if not both_are_zero:
        # Clone history to destroy reference
        var size_x = history_clone[0].len() - 1
        var size_y = history_clone.len() - 1
        var iteration_start = if (dx != 0): vertex[0] else: vertex[1]
        var iteration_goal = if (dx < 0 or dy < 0): 0 else: (if dx != 0: size_x else: size_y)

        for i in iteration_start->iteration_goal:
            var x = vertex[0] + delta * dx
            var y = vertex[1] + delta * dy
            let current_vertex_history = history_clone[y][x]

            if (i != iteration_start and current_vertex_history != 0): break

            history_clone[y][x] = path.len()
            inc delta

        delta = delta - 1

        if (delta < 1):
            return
   
        # check for solved
        var solved = true
        block check_for_solved:
            for y in 0->history_clone.len() - 1:
                for x in 0->history_clone[0].len() - 1:
                    if (history_clone[y][x] == 0):
                        solved = false
                        break check_for_solved

        if (solved):
            return path

    # next
    var current_vertex: array[2, int] = [vertex[0] + delta * dx, vertex[1] + delta * dy]
    ### CHECK DEADENDS HERE ###
    var deadends = find_deadends(history_clone, current_vertex[0], current_vertex[1])
    if (deadends > 1):
        return

    for i in order:
        var direction: string = i[0]
        var new_dx: int
        var new_dy: int
    
        discard parseInt(i[1], new_dx)
        discard parseInt(i[2], new_dy)

        var results = solve(
            current_vertex,
            history_clone,
            new_dx,
            new_dy,
            path & direction    
        )

        if (results.len() > 0):
            return results

echo "A Solver for Mortal Coil by Corned"
echo "\thttp://www.hacker.org/coil\n"

echo "Input flashvars:"
let flashvars: string = readLine(stdin)

var properties = extract_properties(flashvars)
var board = construct_board(properties)
var board_size_x = board[0].len()
var board_size_y = board.len()

var history = newSeq[seq[int]](0)
var starting_vertices = newSeq[array[2, int]](0)

# Construct history && starting_vertices
for y in 0->board_size_y - 1:
    history.add(newSeq[int](0))
    for x in 0->board_size_x - 1:
        if board[y][x] == 'X':
            history[y].add(-1)
        else:
            history[y].add(0)
            let arr: array[2, int] = [x, y]
            starting_vertices.add(arr)


var t0 = cpuTime()
for index in countup(0, starting_vertices.len() - 1):
    var vertex = starting_vertices[index]
    var results = solve(vertex, history, 0, 0, "")
    if (results.len() > 0):
        echo "\n",format(vertex, results),"\n"
        break

echo "Time taken: ", (cpuTime() - t0) , "s"
echo "\nPress enter to quit.."

discard readLine(stdin)

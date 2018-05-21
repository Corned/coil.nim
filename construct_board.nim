import parseutils

proc construct_board*(properties: seq[string]): seq[seq[char]] =
    var size_x = 0
    var size_y = 0
    var vertex_data = properties[2]
    
    discard parseInt(properties[0], size_x)
    discard parseInt(properties[1], size_y)
    
    result = newSeq[seq[char]](0)
    for y in countup(0, size_y - 1):
        result.add(newSeq[char](0))
        for x in countup(0, size_x - 1):
            result[y].add(vertex_data[x + y * size_x])
import strutils

proc format*(vertex: array[2, int], path: string): string =
    return "http://www.hacker.org/coil/index.php?x=" & intToStr(vertex[0]) & "&y=" & intToStr(vertex[1]) & "&path=" & path

iterator `->`*[T](a: T, b: T): T =
    var res: T = T(a)

    if (a != b):
        if (res < b):
            while res <= b:
                yield res
                res = res + 1
        else: 
            while res >= b:
                yield res
                res = res - 1
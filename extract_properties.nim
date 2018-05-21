import re

proc extract_properties*(flashvars: string): seq[string] =
    result = newSeq[string](0)
    for property in flashvars.split(re"\&"):
        result.add(property.split(re"\=")[1])
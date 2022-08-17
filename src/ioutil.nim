import std/strutils
proc read_archivo*(filename:string):seq[float]=
    let f = open(filename)
    # Close the file object when you are done with it
    defer: f.close()
    var numeros= newSeq[float](0)
    for line in lines f:
        numeros.add(parseFloat(line))
    numeros

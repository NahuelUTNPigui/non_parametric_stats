import std/strutils
proc read_archivo*(filename:string):seq[float]=
    let f = open(filename)
    # Close the file object when you are done with it
    defer: f.close()
    var numeros= newSeq[float](0)
    for line in lines f:
        numeros.add(parseFloat(line))
    numeros
proc read_archivo_pares*(filename:string):seq[seq[float]]=
    let f = open(filename)
    defer: f.close()
    var numeros=newSeq[seq[float]](50)
    for line in lines f:
        let ss=line.split(" ")
        let vals = @[parseFloat(ss[0]),parseFloat(ss[1])]
        numeros.add(vals)
    numeros
        
        
        
import lib
import std/random
randomize()
proc isOrdered(v:seq[float]):bool=
    var v0=v[0]
    var i=1
    while i < v.len:
        let vx=v[i]
        if(cmp(vx,v0)<0):
            return false
        v0=vx
        inc i
        
    return true
proc add_orden()=
    var ol=Olist[float](v: newSeq[float](0))
    var i =0
    while i<50:
        ol.add(rand(100).float)
        inc i
    echo isOrdered(ol.v)
when isMainModule:
    var ol=Olist[float](v: newSeq[float](0))
    ol.add_rep(4.0)
    ol.add_rep(2.0)
    ol.add_rep(2.0)
    ol.add_rep(2.0)
    ol.add_rep(5.0)
    echo ol.v
    add_orden()


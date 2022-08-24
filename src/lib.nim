import math
type
    Olist*[T] = object
        v* : seq[T]
func len*[T](l:Olist[T]):int=
    l.v.len
func get*[T](l:Olist[T],i:int):T=
    l.v[i]
func search*[T](l:Olist[T],t:T):int=
    var l=0
    var r = l.v.len
    while (l<=r):
        let m=floor((l+r)/2).integer
        let diff=cmp(l.v[m],t)
        if diff<0:
            l=m+1
        elif diff > 0:
            r=m-1
        else:
            return 1
    return -1

proc add*[T](list:var Olist[T],t:T)=
   
    if(list.len==0):
        list.v.add(t)
        
    else:
        var l=0
        var r = list.v.len
        var i:int=0
        #Debo averiguar en que index debo meter
        while (l<=r):
            i=floor((l+r)/2).int
            let diff=cmp(list.v[i],t)
            if diff<0:
                l=i+1
            elif diff > 0:
                r=i-1
        echo i
        if(i>list.v.len):
            list.v.add(t)
proc show*[T](l:Olist[T])=
    for val in l.v:
        echo val

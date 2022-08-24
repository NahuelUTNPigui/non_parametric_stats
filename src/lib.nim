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
#Sin repeticiones
proc add*[T](list:var Olist[T],t:T)=


    if(list.len==0):
        list.v.add(t)
        
    else:
        var l=0
        var r = list.v.len-1
        var i:int=0
        #Debo averiguar en que index debo meter
        while (l<=r):
            if(cmp(list.v[l],t)>0):
                list.v.insert(t,l)
                break
            if(cmp(list.v[r],t)<0):
                list.v.insert(t,r+1)
                break
            i=floor((l+r)/2).int
            let diff=cmp(list.v[i],t)
            var temp_l=l
            var temp_r=r
            if diff<0:
                temp_l=i+1
            elif diff > 0:
                temp_r=i-1
            else:
                break
            if(temp_r<temp_l):
                list.v.insert(t,r-1)
            else:
                l=temp_l
                r=temp_r
        

proc show*[T](l:Olist[T])=
    for val in l.v:
        echo val

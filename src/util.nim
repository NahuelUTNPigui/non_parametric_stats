import std/math
func suma*(x:float,y:float):float=
    x+y

func media*(v:seq[float]):float=
    var res=0.0
    var i=0.0
    if(len(v)==0):
        return res
    if(len(v)==1):
        return v[0]
    else:
        for n in v:
            i+=1
            res=(res*(i-1)+n)/i
    return res
func varianza*(v:seq[float]):float=
    let promedio=media(v)
    var s_2=0.0
    if(len(v)==0):
        return 0.0
    if(len(v)==1):
        return 0.0
    else:
        for n in v:
            s_2+=pow(n-promedio,2)
        let n:float=len(v).float
        return s_2/(n-1)
func std_desv*(v:seq[float]):float=
    pow(varianza(v),1/2)
func z_score_list*(n:float,promedio:float,s:float):float=
    if(s!=0):
        (n-promedio)/s
    else:
        -10
func kurtosis*(v:seq[float]):float=
    let promedio=media(v)
    let std=std_desv(v)
    let n=len(v).toFloat()
    if(n<3):
        return -100
    var k= n*(n+1)/((n-1)*(n-2)*(n-3))
    var sumatoria=0.0
    for x in v:
        sumatoria+=pow((x-promedio)/std,4)
    k*=sumatoria
    k-=3*pow(n-1,2)/((n-2)*(n-3))
    return k

     


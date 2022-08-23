import std/math
import quintil_function
func suma*(x:float,y:float):float=
    x+y

# Se puede hacer mas eficiente con calcular varias cosas a la vez y dar la media y la std por valor
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
    var k= n*(n+1)/((n-1)*(n-2)*(n-3))
    var sumatoria=0.0
    for x in v:
        sumatoria+=pow((x-promedio)/std,4)
    k*=sumatoria
    k-=3*pow(n-1,2)/((n-2)*(n-3))
    return k
func std_k*(n=0.0):float=
    if(n>3):
        pow(24*n*pow(n-1,2)/((n-2)*(n-3)*(n+5)*(n+3)),1/2)
    else:
        -100.0
func skew*(v:seq[float]):float=
    let std=std_desv(v)
    let n= len(v).float
    if(n > 2):
        let m=media(v).float
        var suma=0.0
        for num in v:
            suma += pow(( num - m )/std,3)
        var res = n/((n-1)*(n-2))*suma
        return res
    else:
        return 0.0     
func std_sk*(n=0.0):float=
    if(n>2):
        pow(6*n*(n-1)/((n-2)*(n+1)*(n+3)),1/2)
    else:
        0.0
func is_like*(n1:float,n2:float,err=0.001):bool=
    let abs_diff=abs(n1-n2)
    return abs_diff<=err
func isNormal*(v:seq[float],a:float):bool=
    if(len(v)<2 or a<=0 or a>=1):
        return false
    let k = kurtosis(v)
    let st_k=std_k(len(v).float)
    let sk=skew(v)
    let st_sk=std_sk(len(v).float)
    let zo=acklaman(a)
    let zf=acklaman(1-a)
    let zk=z_score_list(k,0,st_k)
    let zsk=z_score_list(sk,0,st_sk)
    if(zo<=zk and zk<=zf and zsk<=zf and zo<=zsk):
        return true
    else:
        return false
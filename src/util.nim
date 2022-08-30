import std/math
import std/tables
import quintil_function
import lib
type
    EffectSize* = enum
        small,medium,large



func suma*(x:float,y:float):float=
    x+y
func p_from_zeta_zelen_severo(z:float):float=
    let a=0.4361836
    let b=0.1201676
    let c = 0.937298
    let t = pow(1+0.033267*z,-1)
    1-(a*t-b*t*t+c*pow(t,3))*pow(E,-1*pow(z,2)/2)/sqrt(2*PI)
# Se puede hacer mas eficiente con calcular varias cosas a la vez y dar la media y la std por valor
#Capitulo 2
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
#Capitulo 3
func diff_table*(pairs:seq[seq[float]]): Table[int,float] =
    var t=initTable[int,float]()
    var i=0
    for pair in pairs:
        let x1=pair[0]
        let x2=pair[1]
        if(abs(x1-x2) > 0.001):
            t[i]=x2-x1
        inc i
    return t
func compute_t*(t:var Table[int,float]):float=
    var sum_pos=0.0
    var sum_neg=0.0
    for v in t.mvalues:
        if(v>0):
            sum_pos += v
        else:
            sum_neg = sum_neg + v
    min(sum_pos,abs(sum_neg))
#Si es verdadero entonces no hay diferencias, si es falso hay diferencias
func wilcoxon_signed_rank*(v:seq[seq[float]],alfa:float):bool=
    var diffs=diff_table(v)
    let n=diffs.len.toFloat
    let mean=n*(n+1)/4
    let st=pow(n*(n+1)*(2*n+1)/24,1/2)
    let t=compute_t(diffs)
    let z = z_score_list(t,mean,st)
    #Debo usar al alfa como 0.025 y 0.975 si pongo un alfa del 0.05
    let expected_z=acklaman(1-alfa/2)
    if z<expected_z and z > -1*expected_z:
        return true
    else:
        return false
    return false
#Si es verdadero entonces no hay diferencias, si es falso hay diferencias
func sign_test*(v:seq[seq[float]],alfa:float):bool=
    var np=0.0
    var nn=0.0
    for pair in v:
        let diff=pair[1]-pair[0]
        if(abs(diff)<0.001):
            if(diff<0):
                nn += 1
            else:
                np += 1
    let z=(max(np,nn)-0.5*(np+nn)-0.5)/(0.5*pow(np+nn,1/2))
    let p1=1-p_from_zeta_zelen_severo(z)
    let p=p1*2
    if p<alfa:
        return true
    else:
        return false
func toEffectSize*(z:float,n:float):EffectSize=
    let res=abs(z)/sqrt(n)
    if res<=0.1:
        return small
    elif res<=0.3:
        return medium
    else:
        return large
#Capitulo 4
func compute_ranks*(v:seq[seq[float]]):Olist=
    Olist()
#Este esta mas dificil, los empates comparten el rank
#Esta vez es diferente el primer valor representa la columna y el segundo la fila
func mann_whitney_u_test*(v:seq[seq[float]],alfa:float):bool=
    let n1=v[0].len
    let n2=v[1].len
    let xu=n1*n2/2
    let su=sqrt(n1*n2*(n1+n2+1)/24)
    
import math
#Se asume que alfa sera entre 0 y 1
func acklaman*(p:float):float=
    if(p==0):
        return 0.5
    let a=[
        -0.3969683028665376,
        0.02209460984245205,
        -0.02759285104469687,
        0.01383577518672690,
        -0.3066479806614716,
        2.506628277459239
    ]
    let b=[
        -0.5447609879822406,
        0.01615858368580409,
        -0.01556989798598866,
        0.6680131188771972,
        -0.1328068155288572
    ]
    let c=[
        -0.007784894002430293,
        -0.3223964580411365,
        -2.400758277161838,
        -2.549732539343734,
        4.374664141464968,
        2.938163982698783
    ]
    let d=[
        0.007784695709041462,
        0.3224671290700398,
        2.445134137142996,
        3.754408661907416
    ]
    let plow=0.02425
    let phigh= 1 - plow
    
    if p < plow:
       let q  = sqrt(-2.float*ln(p))
       return (((((c[0]*q+c[1])*q+c[2])*q+c[3])*q+c[4])*q+c[5]) / ((((d[0]*q+d[1])*q+d[2])*q+d[3])*q+1)
    if phigh < p:
       let q  = math.sqrt(-2*ln(1-p))
       return -(((((c[0]*q+c[1])*q+c[2])*q+c[3])*q+c[4])*q+c[5]) / ((((d[0]*q+d[1])*q+d[2])*q+d[3])*q+1)
    let q = p - 0.5
    let r = q*q
    return (((((a[0]*r+a[1])*r+a[2])*r+a[3])*r+a[4])*r+a[5])*q / (((((b[0]*r+b[1])*r+b[2])*r+b[3])*r+b[4])*r+1)
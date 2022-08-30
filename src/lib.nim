import math
type
    Contador* = object
        nombre:string
        counter:int
proc newContador(nombre:string):Contador=
    Contador(nombre:nombre,counter:1)
type
    ParValorContador=object
        valor:float
        contador:Contador
proc newParValorContador(valor:float,nombre:string):ParValorContador=
    ParValorContador(valor:valor,contador:newContador(nombre))

func `inc`(par:var ParValorContador)=
    inc par.contador.counter
type
    Olist* = object
        #Pero puede haber 1 o 2 contadores
        v* : seq[ParValorContador]
func len*(l:Olist):int=
    l.v.len
func getValor*(l:Olist,i:int):float=
    l.v[i].valor
#Con repeticiones
proc add_rep*(list: var Olist,t:float,nombre:string)=
    if(list.len==0):
        list.v.add(newParValorContador(t,nombre))       
    else:
        var l=0
        var r = list.v.len-1
        var i:int=0
        #Debo averiguar en que index debo meter
        while (l<=r):
            #No existe
            if(cmp(list.v[l].valor,t)>0):
                list.v.insert(newParValorContador(t,nombre),l)
                return
            #No existe
            if(cmp(list.v[r].valor,t)<0):
                list.v.insert(newParValorContador(t,nombre),r+1)
                return
            i=floor((l+r)/2).int
            let diff=cmp(list.v[i].valor,t)
            var temp_l=l
            var temp_r=r
            if diff<0:
                temp_l=i+1
            elif diff > 0:
                temp_r=i-1
            else:
                #Existe
                list.v.insert(newParValorContador(t,nombre),i)
                return
            #No existe
            if(temp_r<temp_l):
                list.v.insert(newParValorContador(t,nombre),r-1)
                return
            else:
                l=temp_l
                r=temp_r
proc show*(l:Olist)=
    for par in l.v:
        echo par.valor

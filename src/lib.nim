import math
type
    Contador*[T] = object
        valor*:T
        counter_1*:int
        counter_2*:int
proc newContador[T](valor:T):Contador[T]=
    Contador[T](valor:valor,counter_1:0,counter_2:0)
proc contar_mas_1[T](c: var Contador[T],numero:int)=
    if(numero==1):
        inc c.counter_1
    else:
        inc c.counter_2
type
    Olist*[T] = object
        #Pero puede haber 1 o 2 contadores
        v* : seq[Contador[T]]
proc newOlist*[T]():Olist[T]=
    Olist[T](v : newSeq[Contador[T]](0))
func len*[T](l:Olist[T]):int=
    l.v.len
func getContador*[T](l:var Olist[T],i:int):var Contador[T]=
    l.v[i]
func search_valor*[T](ol:Olist[T],t:T):int=
    var l=0
    var r = ol.v.len
    while (l<=r):
        let m = floor((l+r)/2).toInt
        let diff=cmp(ol.v[m].valor,t)
        if diff<0:
            l=m+1
        elif diff > 0:
            r=m-1
        else:
            return m
    return -1
#Sin repeticiones
proc add*[T](list: var Olist[T],t:T)=
    if(list.len==0):
        list.v.add(newContador(t))       
    else:
        var l=0
        var r = list.v.len-1
        var i:int=0
        #Debo averiguar en que index debo meter
        while (l<=r):
            #No existe
            if(cmp(list.v[l].valor,t)>0):
                list.v.insert(newContador(t),l)
                return
            #No existe
            if(cmp(list.v[r].valor,t)<0):
                list.v.insert(newContador(t),r+1)
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
                return
            #No existe
            if(temp_r<temp_l):
                list.v.insert(newContador(t),r-1)
                return
            else:
                l=temp_l
                r=temp_r
proc contar_lista*[T](olist:var Olist[T],lista:seq[T],numero:int)=

    for valor in lista:
        olist.getContador(olist.search_valor(valor)).contar_mas_1(numero)
        
proc inicializar_list*[T](olist: var Olist[T],valores:seq[T])=
    for valor in valores:
        olist.add(valor)
proc show*(l:Olist)=
    for counter in l.v:
        echo counter

proc sumar_ranks*[T](ol:Olist[T],numero:int):int=
    var suma=0
    for contadores in ol.v:
        if (numero==1):
            suma += contadores.counter_1
        else:
            suma += contadores.counter_2
    suma
import lib
import std/random
import std/strutils
randomize()
proc test_olist()=
    var olist = newOlist[float]()
    var lista = @[1.0,2,5,1,5,1,5,6,4,1,67,9,2,3]
    olist.inicializar_list(lista)
    var l_1 = @[1.0,2.0,3.0,2.0]
    var l_2 = @[3.0,3.0,5.0,6.0]
    olist.contar_lista(l_1,1)
    olist.contar_lista(l_2,2)
    let suma_ranks_1=olist.sumar_ranks(1)
    olist.show()
proc test_smalles_closest_index()=
    let lista = @[1.0,3,6,9,10,11,20,34,55,87,90]
    let test_lista= @[0.0,1.0,2,3,4,5,8,12,23,56,70,40,78,1000,21]
    for test in test_lista:
        echo "valor: " & $test  & " indice: " & $smallest_closest_index(lista,test)
when isMainModule:
    test_smalles_closest_index()    




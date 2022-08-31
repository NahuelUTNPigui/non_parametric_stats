import lib
import std/random
randomize()

when isMainModule:
    
    var olist = newOlist[float]()
    var lista = @[1.0,2,5,1,5,1,5,6,4,1,67,9,2,3]
    olist.inicializar_list(lista)
    var l_1 = @[1.0,2.0,3.0,2.0]
    var l_2 = @[3.0,3.0,5.0,6.0]
    olist.contar_lista(l_1,1)
    olist.contar_lista(l_2,2)
    let suma_ranks_1=olist.sumar_ranks(1)
    olist.show()



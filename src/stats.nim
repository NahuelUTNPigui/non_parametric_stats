# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import util
import ioutil
import std/os
import std/strutils
proc ioutilidad(filename:string):seq[float]=
  read_archivo(filename)
proc ioutilidad_par(filename:string):seq[seq[float]]=
  read_archivo_pares(filename)
proc print_opt(valores:seq[float],opt:proc (v:seq[float]):float)=
  echo opt(valores)
proc print_opt_alt(n:float,opt:proc(n:float):float)=
  echo opt(n)

proc print_opciones(filename:string,opcion:string,alfa=0.05)=
  if(opcion=="m"):
    let valores=ioutilidad(filename)
    print_opt(valores,media)
  elif(opcion=="std"):
    let valores=ioutilidad(filename)
    print_opt(valores,std_desv)
  elif(opcion=="k"):
    let valores=ioutilidad(filename)
    print_opt(valores,kurtosis)
  elif(opcion=="std_k"):
    let valores=ioutilidad(filename)
    print_opt_alt(len(valores).float,std_k)
    
  elif(opcion=="sk"):
    let valores=ioutilidad(filename)
    print_opt(valores,skew)
  elif(opcion=="is_norm"):
    let valores=ioutilidad(filename)
    echo isNormal(valores,alfa)
proc print_opciones_par(filename:string,opcion:string)=
  if(opcion=="pares"):
    let valores=ioutilidad_par(filename)
    for n in valores:
      echo n
when declared(commandLineParams):
    echo "old pc"
    if(commandLineParams().len()>0):
      
      let opcion= commandLineParams()[1]
      var alfa=0.05
      print_opciones(commandLineParams()[0],opcion,alfa)
      print_opciones_par(commandLineParams()[0],opcion)
    else:
      echo "no params"
else:
    echo "no params"
  
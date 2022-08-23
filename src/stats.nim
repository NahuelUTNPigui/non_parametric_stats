# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import util
import ioutil
import std/os
proc utilidad()=
  echo suma(1,1)
  
  
proc ioutilidad(filename:string):seq[float]=
  read_archivo(filename)
proc print_opt(valores:seq[float],opt:proc (v:seq[float]):float)=
  echo opt(valores)
proc print_opt_alt(n:float,opt:proc(n:float):float)=
  echo opt(n)
proc print_opciones(valores:seq[float],opcion:string)=
  if(opcion=="m"):
    print_opt(valores,media)
  elif(opcion=="std"):
    print_opt(valores,std_desv)
  elif(opcion=="k"):
    print_opt(valores,kurtosis)
  elif(opcion=="std_k"):
    print_opt_alt(len(valores).float,std_k)
  elif(opcion=="sk"):
    print_opt(valores,skew)
  else:
    print_opt_alt(len(valores).float,std_sk)
when declared(commandLineParams):
    if(commandLineParams().len()>0):
      let valores =ioutilidad(commandLineParams()[0])
      let opcion= commandLineParams()[1]
      print_opciones(valores,opcion)
    else:
      echo "no params"
else:
    echo "no params"
  
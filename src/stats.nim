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
proc print_opciones(valores:seq[float],opcion:string)=
  if(opcion=="m"):
    print_opt(valores,media)
  elif(opcion=="std"):
    print_opt(valores,std_desv)
  else:
    print_opt(valores,kurtosis)
when declared(commandLineParams):
    
    let valores =ioutilidad(commandLineParams()[0])
    let opcion= commandLineParams()[1]
    print_opciones(valores,opcion)
else:
    echo "no params"
  
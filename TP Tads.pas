TAD  Tpaquete;
interface
type exportado paquete

procedure crearPaquete(var p: paquete; ciud: string; prov: string;  cod_postal: integer; cant_atrac: integer; precio: real);

procedure asignarPaquete(var p1: paquete; p2: paquete);

procedure verNombreCiudad(p: paquete; var nom: string);

function verPrecioPaquete(p: paquete): real;

function verCodigoPostal(p: paquete): integer;

procedure verProvincia(p: paquete; var prov: string);

function verCantidadAtracciones(p: paquete): integer;

implementation

  paquete = record
          ciudad: string[30];
          prov: string[30];
          codPostal: integer;
          cantAtrac: integer;
          precio: real;
          end;

procedure crearPaquete(var p: paquete; ciud: string; prov: string;  cod_postal: integer; cant_atrac: integer; precio: real);
          begin
          p.ciudad:= ciud;
          p.prov:= prov;
          p.codPostal:= cod_postal;
          p.cantAtrac:= cant_atrac;
          p.precio:= precio;
          end;

procedure asignarPaquete(var p1: paquete; p2: paquete);
          begin
          p1:= p2;
          end;

function verPrecioPaquete(p: paquete): real;
         begin
         verPrecioPaquete:= p.precio;
         end;

program TPtads;
uses Tpaquete;
const inf = 1910; sup = 1950;
type
    atraccion = record
              nom: string[30];
              dom: string[30];
              precio: real;
              end;

    listaAtracciones = ^nodoAtrac;

    nodoAtrac = record
              datos: ataccion;
              sig: listaAtracciones;

    ciudad = record
           nom: string[30];
           codPostal: integer;
           nomProv: string[30];
           listaAtrac: listaAtracciones;
           end;

    listaCiudad = ^nodoCuidad;

    nodoCuidad = record
               datos: ciudad;
               sig: listaCuidad;
               end;

    arbol = ^nodoArbol;

    nodoArbol = record
              dato: paquete;
              Hi: arbol;
              Hd: arbol;
              end;

procedure recorrerCuidad(listaAtrac: listaAtraciones; var cantAtrac: integer, var precio: real);
        begin
          cantAtrac:=0;
          precio:=0;
          while(listaAtrac <> nil) do begin
            cantAtrac:= cantAtrac+1;
            precio:= precio + listaAtrac^.datos.precio;
            listaAtrac:= listaAtrac^.sig;
          end;
        end;

 procedure asignarPaquetes(var A: arbol; p: paquete);
           var nomCiu, nomProv: string;
           begin
           verNombreCiudad(p: paquete; var nom: string);
           A^.dato.cuidad:= nomCiu;
           verProvincia(p: paquete; var prov: string);
           A^.dato.prov:= nomProv;
           A^.dato.codPostal:= verCodigoPostal(p: paquete);
           A^.dato.cantAtrac:= verCantidadAtracciones(p: paquete);
           A^.dato.precio:=  verPrecioPaquete(p: paquete);
           end;

procedure insertarArbol(var L: listaCuidad; paq: paquete; A: arbol);
      begin
      if(A = nil) then  begin
           new(A);
           asignarValores(A, paq);
      end
      else
          if(L^.datos.codPostal < A^.dato.codPostal) then
             insertarArbol(L, paq, A^.Hi)
          else
            insertarArbol(L, paq, A^.Hd);
      end;

procedure crearArbol(L: listaCuidad; var A: arbol);
        var p: paquete; paq: paquete; ciudad, prov: string[30]; codPostal, cantAtrac: integer; precio: real;
        begin
          while(L <> nil) do begin
               recorrerCuidad(L^.datos.listaAtrac, cantAtrac, precio);
               crearPaquete(p, cuidad, prov, codPostal, cantAtrac, precio);
               asignarPaquete(paq, p);
               insertarArbol(L, paq, A);
               datosCuidad^.sig;
          end;
        end;

procedure informarPaq(A: arbol; var cantAtrac: integer);
begin
  if (A <> nil) then
    if (A^.dato.codPostal >= inf) then
      if (A^.dato.codPostal <= sup) then begin
        cantAtrac:= cantAtrac+1;
        busqueda_acotada(A^.Hi, cantAtrac);
        busqueda_acotada(A^.Hd, cantAtrac);
      end
      else
        busqueda_acotada(A^.Hi, cantAtrac)
    else
      busqueda_acotada(A^.Hd, cantAtrac);
end;

procedure cantPaqBsAs(A: arbol; var cantpaq: integer);
        begin
          while (A <> nil) do begin
            if(A^.dato.prov = 'Buenos Aires') and (A^.dato.precio > 200) then
              cantpaq:= cantpaq+1;
            cantPaqBsAs(A^.Hi, cantpaq);
            cantPaqBsAs(A^.Hd, cantpaq);
          end;
        end;

var L: listaCuidad; A: arbol; cantAtarc: integer; cantpaq: integer;
begin
    crearArbol(L, A);
    cantAtrac:=0;
    cantpaq:=0;
    InformarPaq(A);
    writeln('La cantidad de atracciones entre los codigos postales 1930 y 1950 son ', cantAtrac);
    cantPaqBsAs(A, cantpaq);
    writen('La cantidad de paquetes turisticos de Buenos Aires y con un precio mayor a 200 son', cantpaq);
    readln;
end.

% dodain atiende lunes, miércoles y viernes de 9 a 15.
% lucas atiende los martes de 10 a 20
% juanC atiende los sábados y domingos de 18 a 22.
% juanFdS atiende los jueves de 10 a 20 y los viernes de 12 a 20.
% leoC atiende los lunes y los miércoles de 14 a 18.
% martu atiende los miércoles de 23 a 24.

% ============================================Punto 1=====================================================

% Definir la relación para asociar cada persona con el rango horario que cumple, 

% turno(Persona,Dia,HoraInicial,HoraFinal)
turno(dodain,lunes,9,15).
turno(dodain,miercoles,9,15).
turno(dodain,viernes,9,15).
turno(lucas,martes,10,20).
turno(juanC,sabado,18,22).
turno(juanC,domingo,18,22).
turno(juanFdS,jueves,10,20).
turno(juanFdS,viernes,12,20).
turno(leoC,lunes,14,18).
turno(leoC,miercoles,14,18).
turno(martu,miercoles,23,24).

% e incorporar las siguientes cláusulas:
%   vale atiende los mismos días y horarios que dodain y juanC.
turno(vale,Dia,HoraInicial,HoraFinal):-
    turno(dodain,Dia,HoraInicial,HoraFinal).

turno(vale,Dia,HoraInicial,HoraFinal):-
    turno(juanC,Dia,HoraInicial,HoraFinal).

%   nadie hace el mismo horario que leoC
% No se desarrolla por principio de universo cerrado, todo lo que no esta en nuestra base de conocimientos es falso, es por eso que hacer una consulta de si alguien atiende en el mismo horario que leoC es en vano.

%   maiu está pensando si hace el horario de 0 a 8 los martes y miércoles
% Podriamos desarrollar un estaPensando/1 pero sería agregar codigo en vano ya que no es efectivo, no está siendo efectivo el hecho.

% ============================================Punto 2=====================================================


%   Definir un predicado que permita relacionar un día y hora con una persona, en la que dicha persona atiende el kiosko. Algunos ejemplos:
% si preguntamos quién atiende los lunes a las 14, son dodain, leoC y vale
% si preguntamos quién atiende los sábados a las 18, son juanC y vale
% si preguntamos si juanFdS atiende los jueves a las 11, nos debe decir que sí.
% si preguntamos qué días a las 10 atiende vale, nos debe decir los lunes, miércoles y viernes.

% El predicado debe ser inversible para relacionar personas y días.

% atiende(Persona,Dia,RangoHorario)
atiende(Persona,Dia,Hora):-
    turno(Persona,Dia,HoraInicial,HoraFinal),
    between(HoraInicial, HoraFinal, Hora).

% ============================================Punto 3=====================================================

% Definir un predicado que permita saber si una persona en un día y horario determinado está atendiendo ella sola. En este predicado debe utilizar not/1, y debe ser inversible para relacionar personas. Ejemplos:
% si preguntamos quiénes están forever alone el martes a las 19, lucas es un individuo que satisface esa relación.
% si preguntamos quiénes están forever alone el jueves a las 10, juanFdS es una respuesta posible.
% si preguntamos si martu está forever alone el miércoles a las 22, nos debe decir que no (martu hace un turno diferente)
% martu sí está forever alone el miércoles a las 23
% el lunes a las 10 dodain no está forever alone, porque vale también está

estaSola(Persona,Dia,Hora):-
    atiende(Persona,Dia,Hora),
    not(estaConAlguien(Persona,Dia,Hora)).

estaConAlguien(Persona,Dia,Hora):-
    atiende(Persona,Dia,Hora),
    atiende(OtraPersona,Dia,Hora),
    Persona \= OtraPersona.   

% ============================================Punto 4=====================================================
% Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko en algún momento de ese día. Por ejemplo, si preguntamos por el miércoles, tiene que darnos esta combinatoria:
% nadie
% dodain solo
% dodain y leoC
% dodain, vale, martu y leoC
% vale y martu
% etc.

% Queremos saber todas las posibilidades de atención de ese día. La única restricción es que la persona atienda ese día (no puede aparecer lucas, por ejemplo, porque no atiende el miércoles).

% Punto extra: indique qué conceptos en conjunto permiten resolver este requerimiento, justificando su respuesta.
trabajanEnElDia(Dia,PersonasQueTrabajan):-
    findall(Persona, atiende(Persona,Dia,_), ListaDePersonas),
    list_to_set(ListaDePersonas, SetDePersonas),
    subconjunto(SetDePersonas,PersonasQueTrabajan).                                
    
subconjunto([], []).

subconjunto([Elemento | ColaListaOriginal],[Elemento | ColaSubconjunto]) :-
    subconjunto(ColaListaOriginal, ColaSubconjunto).

subconjunto([_ | ColaListaOriginal], Subconjunto) :-
    subconjunto(ColaListaOriginal, Subconjunto).        
    
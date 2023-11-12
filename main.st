Object subclass: #Wielokat
	instanceVariableNames: 'wierzcholki nazwa '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!

!Wielokat methodsFor: 'initialize-release'!

initialize: liczbaWierzcholkow name: nowaNazwa
	"konstruktor obiektu - wielokata"

	nazwa:=nowaNazwa.
	wierzcholki:=Array new: liczbaWierzcholkow.
	wierzcholki at: 1 put: 0@0.! !

!Wielokat methodsFor: 'actions'!

drukuj
    "drukowanie opisu figury"
    | roundedPole x y|
    
    roundedPole:= ((self pole) roundTo: 0.0001).
    Transcript show: 'Dana jest figura: ', (self nazwa) printString; cr.
    1 to: wierzcholki size do: [ :index|
        x:= ((wierzcholki at: index) x roundTo: 0.0001).
        y:= ((wierzcholki at: index) y roundTo: 0.0001).
        Transcript show: 'Wierzcholek ', index asString, ': ', x printString, ' @ ',y printString ; cr.
    ]. 
    Transcript show: 'Pole: ', (roundedPole) printString; cr. ! !

!Wielokat methodsFor: 'accessing'!

nazwa
	"podaje nazwe wielokata"

	^nazwa!

nazwa: nowa_nazwa
	"ustawia nowa nazwe wielokata"

	nazwa:=nowa_nazwa! !

!Wielokat methodsFor: 'actions'!

wysrodkuj
    "Move the figure so that the center of the coordinate system is at the intersection point of the heights"
    | center |

    "Calculate the center of the figure"
    "center := (self poleCenter)."
    
    center := 1@1.

    "Translate all vertices to center the figure"
    1 to: wierzcholki size do: [ :index |
        wierzcholki at: index put: ((wierzcholki at: index) - center) rounded.
    ].

    "Update the pole to reflect the new position"
    self pole.

    "Print the information after centering"
    Transcript show: 'Po wysrodkowaniu:'; cr.
    self drukuj.! !
    

Wielokat subclass: #Kwadrat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!


!Kwadrat methodsFor: 'arithmetic'!

+ figura
	"dodaj 2 figury w sensie pola"

	| p |

	p:=self pole + figura pole.
	^(Kwadrat new) initialize: p sqrt! !

!Kwadrat methodsFor: 'actions'!

pole
	"licz pole kwadratu"

	^(wierzcholki at: 2) x squared! !

!Kwadrat methodsFor: 'initialize-release'!

initialize: bok
	"tworz kwadrat o podanym boku"

	super initialize: 4 name: 'Kwadrat'.
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: bok@bok.
	wierzcholki at: 4 put: 0@bok.! !
	
	
Wielokat subclass: #Trojkat_rownoramienny
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!


!Trojkat_rownoramienny methodsFor: 'arithmetic'!

+ figura
	"dodaj 2 figury w sensie pola"

	| a h x y |
	
	a:= (wierzcholki at: 2) x.
	h:=(wierzcholki at: 3) y.
	x:= h* ((1+((2*figura pole)/(a*h))) sqrt).
	y:= a* ((1+((2*figura pole)/(a*h))) sqrt).
	^(Trojkat_rownoramienny new) initialize: x wysokosc: y. ! !

!Trojkat_rownoramienny methodsFor: 'actions'!

calculateBaseHeight
    | baseMidpoint point|
            baseMidpoint := ((wierzcholki at: 1) + (wierzcholki at: 2)) / 2. "Midpoint of the base of the triangle"
            point := (baseMidpoint) dist: (wierzcholki at: 3).
            "Transcript show: 'Srodek ', point x asString; cr."
            ^ (baseMidpoint) dist: (wierzcholki at: 3)! "Height of the isosceles triangle"

intersectionPointOfHeights 
    | heightA heightB intersectionPoint pointA pointB pointC baseHeight|
        baseHeight := self calculateBaseHeight.
        pointA := (wierzcholki at: 1).
        pointB := (wierzcholki at: 2).
        pointC := (wierzcholki at: 3).
        heightA := (pointC - pointA) * (baseHeight / (pointC - pointA) normal) + pointA. 
        heightB := (pointC - pointB) * (baseHeight / (pointC - pointB) normal) + pointB. 
        intersectionPoint := (heightA + heightB) / 2.
        ^ intersectionPoint. !

znajdz_srodek
    | podX1 podY1 podX2 podY2 x y heightA heightB pointA pointB pointC intersectionPoint |
    "srodek podstawy"
    podX1 := (wierzcholki at: 1) x.
    podY1 := (wierzcholki at: 1) y.
    podX2 := (wierzcholki at: 2) x.
    podY2 := (wierzcholki at: 2) y.
    x := (podX1 + podX2) / 2.
    y := (podY1 + podY2) / 2.

    pointA := (wierzcholki at: 1).
    pointB := (wierzcholki at: 2).
    pointC := (wierzcholki at: 3).
    heightA := ((pointC - pointA) normal) * 2 + pointA.
    "heightA := (pointA) distanceTo: pointB."
    heightB := ((pointC - pointB) normal) * 2 + pointB.
    intersectionPoint := (heightA + heightB) / 2. 
    
    Transcript show: 'Srodek ', intersectionPoint x asString; cr.
    ^ Point x: x y: y!
    
pole
	"licz pole trojkata"
    | area |

    area := 0.5 * (wierzcholki at: 2) x * (wierzcholki at: 3) y.

    ^ area!!

!Trojkat_rownoramienny methodsFor: 'initialize-release'!

initialize: podstawa wysokosc: h
	"tworz trojkat rownoramienny o podanych parametrach"
    | podzielone |
    podzielone := podstawa / 2.
	super initialize: 3 name: 'Trojkat_rownoramienny'.
	wierzcholki at: 2 put: podstawa@0.
	wierzcholki at: 3 put: podzielone@h.!!
	
	

t := (Trojkat_rownoramienny new) initialize: 2
wysokosc: 2.
t1 := (Trojkat_rownoramienny new) initialize: 4
wysokosc: 2.
t3 := t + t1.


Transcript show: 'Dane sa wielokaty:'; cr.
t drukuj.
t1 drukuj.
t3 drukuj.
t wysrodkuj.
elo := t intersectionPointOfHeights.
Transcript show: 'Dane sa wielokaty:', elo printString;cr.

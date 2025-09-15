Class {
	#name : #Z3FloatingPointSort,
	#superclass : #Z3Sort,
	#category : #'Z3-Core'
}

{ #category : #inhabitation }
Z3FloatingPointSort >> anyOne [
	
	^ 0.0 toFloatingPoint: self length
]

{ #category : #'type theory' }
Z3FloatingPointSort >> cast: value [
	
	^ value toFloatingPoint: self length
]

{ #category : #'type theory' }
Z3FloatingPointSort >> length [
	"Return length in bits"

	^ (Z3 fpa_get_ebits: ctx _: self)
	  + (Z3 fpa_get_sbits: ctx _: self)
]

{ #category : #'type theory' }
Z3FloatingPointSort >> nodeClass [

	^ FloatingPoint

]

Class {
	#name : #HCon,
	#superclass : #HThing,
	#category : #Refinements
}

{ #category : #syntax }
HCon class >> parser [
	^'constant' asParser trim,
	self tok trim, "name"
	self sort
	==> [ :x | self new ]
]

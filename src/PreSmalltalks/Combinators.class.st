Class {
	#name : #Combinators,
	#superclass : #SharedPool,
	#classVars : [
		'K'
	],
	#category : #PreSmalltalks
}

{ #category : #'class initialization' }
Combinators class >> initialize [
	K := [ :x :_ | x ].
]

Class {
	#name : #Brel,
	#superclass : #SharedPool,
	#classVars : [
		'Eq',
		'Ge',
		'Gt',
		'Iff',
		'Le',
		'Lt',
		'Ne',
		'Ueq',
		'Une'
	],
	#category : #Refinements
}

{ #category : #'class initialization' }
Brel class >> initialize [
	"
	self initialize
	"
	Eq := #===.
	Ne := #~==.
	Ge := #>=.
	Gt := #>.
	Le := #<=.
	Lt := #<.
	Ueq := #====.
	Une := #~===.
	
	Iff := #<=>.
]

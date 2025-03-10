Class {
	#name : #Bop,
	#superclass : #SharedPool,
	#classVars : [
		'Div',
		'Minus',
		'Plus',
		'Times'
	],
	#category : #'Refinements-Core'
}

{ #category : #'class initialization' }
Bop class >> initialize [
	"
	self initialize
	"
	Plus   :=  #+.
	Minus  :=  #-.
	Times  :=  #*.
	Div    :=  #/.

]

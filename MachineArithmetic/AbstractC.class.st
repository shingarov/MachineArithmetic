Class {
	#name : #AbstractC,
	#superclass : #Object,
	#instVars : [
		'env',
		'rhs',
		'id',
		'tag',
		'info'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #accessing }
AbstractC >> env [
	^ env
]

{ #category : #accessing }
AbstractC >> env: anObject [
	env := anObject
]

{ #category : #accessing }
AbstractC >> id [
	^ id
]

{ #category : #accessing }
AbstractC >> id: anObject [
	id := anObject
]

{ #category : #accessing }
AbstractC >> info [
	^ info
]

{ #category : #accessing }
AbstractC >> info: anObject [
	info := anObject
]

{ #category : #accessing }
AbstractC >> rhs [
	^ rhs
]

{ #category : #accessing }
AbstractC >> rhs: anObject [
	rhs := anObject
]

{ #category : #accessing }
AbstractC >> tag [
	^ tag
]

{ #category : #accessing }
AbstractC >> tag: anObject [
	tag := anObject
]

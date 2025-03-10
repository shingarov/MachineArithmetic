"
type DepEdge = (F.SubcId, F.SubcId, [F.SubcId])

Cf. Graph/Types.hs
"
Class {
	#name : #DepEdge,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'zs'
	],
	#category : #'Refinements-Graph'
}

{ #category : #accessing }
DepEdge >> x [
	^ x
]

{ #category : #accessing }
DepEdge >> x: anObject [
	x := anObject
]

{ #category : #accessing }
DepEdge >> y [
	^ y
]

{ #category : #accessing }
DepEdge >> y: anObject [
	y := anObject
]

{ #category : #accessing }
DepEdge >> zs [
	^ zs
]

{ #category : #accessing }
DepEdge >> zs: anObject [
	zs := anObject
]

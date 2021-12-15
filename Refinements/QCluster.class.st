"
I wrap around a dictionary compartmentalizing a bunch of Qualifiers by their sig.
"
Class {
	#name : #QCluster,
	#superclass : #Object,
	#instVars : [
		'theDict'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
QCluster class >> of: qualifiers [
	"cf. mkQCluster"
	^self basicNew
		theDict: (qualifiers groupedBy: #sig);
		yourself
]

{ #category : #'as yet unclassified' }
QCluster >> instK: ho env: env v: v t: t [
	^theDict associations collect: [ :sig_qs |
		| sig qs |
		sig := sig_qs key.
		qs := sig_qs value.
		self shouldBeImplemented 
		
		 ]
	
]

{ #category : #'as yet unclassified' }
QCluster >> refineK: ho env: env rft: vtk [
	| v t k eqs eqs1 |
self halt.
	v := vtk first.
	t := vtk second.
	k := vtk third.
	eqs := self instK: ho env: env v: v t: t.
	eqs1 := eqs qbFilter.
	^k -> eqs1
]

{ #category : #accessing }
QCluster >> theDict [
	^ theDict
]

{ #category : #accessing }
QCluster >> theDict: anObject [
	theDict := anObject
]

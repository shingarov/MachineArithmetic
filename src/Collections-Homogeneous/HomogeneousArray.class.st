Class {
	#name : #HomogeneousArray,
	#superclass : #Array,
	#type : #variable,
	#classInstVars : [
		'elementSpecies'
	],
	#category : #'Collections-Homogeneous'
}

{ #category : #accessing }
HomogeneousArray class >> elementSpecies [
	^elementSpecies
]

{ #category : #JSON }
HomogeneousArray class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping |
		mapping listOfElementSchema: elementSpecies
	]
]

{ #category : #testing }
HomogeneousArray >> isHomogeneous [
	^true
]

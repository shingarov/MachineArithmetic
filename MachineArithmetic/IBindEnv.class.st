Class {
	#name : #IBindEnv,
	#superclass : #Object,
	#instVars : [
		'indexes'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
IBindEnv class >> empty [
	^self from: #()
]

{ #category : #'as yet unclassified' }
IBindEnv class >> from: indexes [ 
	^self basicNew 
		indexes: indexes asSet;
		yourself 
]

{ #category : #accessing }
IBindEnv >> indexes [
	^ indexes
]

{ #category : #accessing }
IBindEnv >> indexes: anObject [
	indexes := anObject
]

{ #category : #'as yet unclassified' }
IBindEnv >> insert: j [ 
	^self insertAll: { j. }
]

{ #category : #'as yet unclassified' }
IBindEnv >> insertAll: js [ 
	^IBindEnv from: self indexes, js
]

{ #category : #testing }
IBindEnv >> isEmpty [
	^indexes isEmpty
]

{ #category : #printing }
IBindEnv >> printOn: aStream [
	aStream nextPutAll: 'IBindEnv'.
	self indexes printElementsOn: aStream 
]

{ #category : #'as yet unclassified' }
IBindEnv >> union: anotherIBindEnv [ 
	^self class from: (self indexes union: anotherIBindEnv indexes)
]

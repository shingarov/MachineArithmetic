Class {
	#name : #CardanoTartagliaContext,
	#superclass : #Object,
	#instVars : [
		'env'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
CardanoTartagliaContext >> dummyMethod [
]

{ #category : #'as yet unclassified' }
CardanoTartagliaContext >> env [
	env isNil ifTrue: [env := Dictionary new].
	^ env
]

{ #category : #'as yet unclassified' }
CardanoTartagliaContext >> method [
	^CardanoTartagliaContext >> #dummyMethod
]

{ #category : #'as yet unclassified' }
CardanoTartagliaContext >> receiver [
	^nil
]

{ #category : #'as yet unclassified' }
CardanoTartagliaContext >> tempNamed: aString [
	^self env at: aString
]

{ #category : #'as yet unclassified' }
CardanoTartagliaContext >> tempNamed: aString put: value [
	self env at: aString put: value 
]

{ #category : #'as yet unclassified' }
CardanoTartagliaContext >> tempNames [
	^self env keys
]

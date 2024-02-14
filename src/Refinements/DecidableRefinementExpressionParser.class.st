Class {
	#name : #DecidableRefinementExpressionParser,
	#superclass : #PPSmalltalkParser,
	#instVars : [
		'binaryChar'
	],
	#category : #Refinements
}

{ #category : #primitives }
DecidableRefinementExpressionParser >> binary [
	^binaryChar plus
]

{ #category : #primitives }
DecidableRefinementExpressionParser >> binaryChar [
	| scanner |
	
	"Here we delegate decisiton whether or not a character can occur in 
	 binary selector to RBScanner. For example: MathNotation hacks RBScanner
	 to allow fancy math characters and we do not want to duplicate that code
	 here."
	
	scanner := RBScanner on:'' readStream.
	^ (PPPredicateObjectParser on: [:c | (scanner classify: c) == #binary ] message:'binary')
]

{ #category : #accessing }
DecidableRefinementExpressionParser >> start [
	^sequence
]

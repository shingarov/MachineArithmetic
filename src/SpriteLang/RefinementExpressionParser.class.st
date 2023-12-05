Class {
	#name : #RefinementExpressionParser,
	#superclass : #PPSmalltalkParser,
	#instVars : [
		'binaryChar'
	],
	#category : #'SpriteLang-Parsing'
}

{ #category : #primitives }
RefinementExpressionParser >> binary [
	^binaryChar plus
]

{ #category : #primitives }
RefinementExpressionParser >> binaryChar [
	| scanner |
	
	"Here we delegate decisiton whether or not a character can occur in 
	 binary selector to RBScanner. For example: MathNotation hacks RBScanner
	 to allow fancy math characters and we do not want to duplicate that code
	 here."
	
	scanner := RBScanner on:'' readStream.
	^ (PPPredicateObjectParser on: [:c | (scanner classify: c) == #binary ] message:'binary')
]

{ #category : #accessing }
RefinementExpressionParser >> start [
	^sequence
]

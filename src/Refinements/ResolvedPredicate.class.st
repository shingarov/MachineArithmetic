Class {
	#name : #ResolvedPredicate,
	#superclass : #Expr,
	#instVars : [
		'z3bool'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
ResolvedPredicate class >> z3bool: anAST [
	^self basicNew
		z3bool: anAST;
		yourself
]

{ #category : #visiting }
ResolvedPredicate >> accept: aVisitor [ 
	^self
]

{ #category : #'term rewriting' }
ResolvedPredicate >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^z3bool inEnvironment: aBindEnv constants
]

{ #category : #printing }
ResolvedPredicate >> printOn: aStream [
	aStream nextPut: (Character codePoint: 16r2713). "check mark"
	z3bool printOn: aStream
]

{ #category : #'as yet unclassified' }
ResolvedPredicate >> substPred: th [
	^self "BOGUS!!!!!!"
]

{ #category : #accessing }
ResolvedPredicate >> z3bool [
	^ z3bool
]

{ #category : #accessing }
ResolvedPredicate >> z3bool: anObject [
	z3bool := anObject
]

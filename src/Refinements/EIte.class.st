"
data Expr = ESym !SymConst
  ...
  | EIte !Expr !Expr !Expr
"
Class {
	#name : #EIte,
	#superclass : #Expr,
	#instVars : [
		'b',
		'thenE',
		'elseE'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EIte class >> if: b then: e₁ else: e₂ [
	^self basicNew
		b: b;
		thenE: e₁;
		elseE: e₂;
		yourself
]

{ #category : #'instance creation' }
EIte class >> new [
	self shouldNotImplement
]

{ #category : #accessing }
EIte >> b [
	^ b
]

{ #category : #accessing }
EIte >> b: anObject [
	b := anObject
]

{ #category : #accessing }
EIte >> elseE [
	^ elseE
]

{ #category : #accessing }
EIte >> elseE: anObject [
	elseE := anObject
]

{ #category : #'term rewriting' }
EIte >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^EIte
		if: (b evaluateIn: anEvalEnv ifUndeclared: vndBlock)
		then: (thenE evaluateIn: anEvalEnv ifUndeclared: vndBlock)
		else: (elseE evaluateIn: anEvalEnv ifUndeclared: vndBlock)
]

{ #category : #accessing }
EIte >> thenE [
	^ thenE
]

{ #category : #accessing }
EIte >> thenE: anObject [
	thenE := anObject
]

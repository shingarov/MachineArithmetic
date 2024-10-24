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

{ #category : #visiting }
EIte >> accept: aVisitor [
	b accept: aVisitor.
	thenE accept: aVisitor.
	elseE accept: aVisitor.
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
EIte >> elab: anElabEnv [
	| b′ thenE′ elseE′ outSort |
	b′ := b elab: anElabEnv.
	thenE′ := thenE elab: anElabEnv.
	elseE′ := elseE elab: anElabEnv.
	self assert: thenE′ last = elseE′ last.
	outSort := thenE′ last.
	^{ (EIte
		if: b′ first
		then: thenE′ first
		else: elseE′ first).
		outSort
	}
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

{ #category : #'SMT interface' }
EIte >> smt2 [
	^(b smt2
		ifThen: thenE smt2
		else: elseE smt2
		) simplify
]

{ #category : #accessing }
EIte >> thenE [
	^ thenE
]

{ #category : #accessing }
EIte >> thenE: anObject [
	thenE := anObject
]

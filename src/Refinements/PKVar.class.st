"
data Expr = ...
          | PKVar  !KVar !Subst
Cf. Types/Refinements.hs
"
Class {
	#name : #PKVar,
	#superclass : #Expr,
	#instVars : [
		'var',
		's'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
PKVar class >> var: v subst: s [
	^self basicNew
		var: v;
		s: s;
		yourself
]

{ #category : #visiting }
PKVar >> accept: aVisitor [
	| e1 |
	e1 := aVisitor txExpr value: self.
	"TODO: implement accum"
	^e1
]

{ #category : #elaboration }
PKVar >> elab: anElabEnv [
"
elab _ e@(PKVar _ _) =
  return (e, boolSort)
"
	^{self . Bool sort}
]

{ #category : #'as yet unclassified' }
PKVar >> elabApplyStep: _ [ 
	^self
]

{ #category : #'as yet unclassified' }
PKVar >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^PKVar
		var: var
		subst: (s evaluateIn: aBindEnv ifUndeclared: vndBlock)
]

{ #category : #'as yet unclassified' }
PKVar >> isConc [
	"This should be pulled up."
	^self kvarsExpr isEmpty
]

{ #category : #'as yet unclassified' }
PKVar >> isKVar [
	^true
]

{ #category : #'as yet unclassified' }
PKVar >> isSingletonExpr: v in: env [ 
	^nil
]

{ #category : #'as yet unclassified' }
PKVar >> isTautoPred [
	^false "BOGUS??"
]

{ #category : #'as yet unclassified' }
PKVar >> kvarsExpr [
	^{var}
]

{ #category : #'as yet unclassified' }
PKVar >> predKs [
"cf. Solve.hs"
	^{var->s}
]

{ #category : #printing }
PKVar >> printOn: aStream [ 
	aStream nextPut: $$.
	aStream nextPutAll: var.
	s printOn: aStream
]

{ #category : #accessing }
PKVar >> s [
	^ s
]

{ #category : #accessing }
PKVar >> s: anObject [
	s := anObject
]

{ #category : #'SMT interface' }
PKVar >> smt2: _ [
	^self
]

{ #category : #'term rewriting' }
PKVar >> subst: su [
"
subst su (PKVar k su')   = PKVar k $ su' `catSubst` su
"
	| su′ |
	su′ := s.
	^PKVar
		var: var
		subst: (su′ catSubst: su)
]

{ #category : #accessing }
PKVar >> var [
	^ var
]

{ #category : #accessing }
PKVar >> var: anObject [
	var := anObject
]

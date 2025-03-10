Class {
	#name : #PIff,
	#superclass : #Expr,
	#instVars : [
		'lhs',
		'rhs'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
PIff class >> lhs: l rhs: r [
	^self basicNew
		lhs: l;
		rhs: r;
		yourself
]

{ #category : #comparing }
PIff >> = another [
	self class = another class ifFalse: [ ^false ].
	^ (lhs = another lhs)
	& (rhs = another rhs)
]

{ #category : #visiting }
PIff >> accept: aVisitor [ 
	^PIff
		lhs: (lhs accept: aVisitor)
		rhs: (rhs accept: aVisitor)
]

{ #category : #'term rewriting' }
PIff >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^ (lhs evaluateIn: aBindEnv ifUndeclared: vndBlock)
		<=>
	  (rhs evaluateIn: aBindEnv ifUndeclared: vndBlock)
]

{ #category : #comparing }
PIff >> hash [
	^lhs hash
]

{ #category : #logic }
PIff >> isTautoPred [
	^lhs = rhs
]

{ #category : #accessing }
PIff >> lhs [
	^ lhs
]

{ #category : #accessing }
PIff >> lhs: anObject [
	lhs := anObject
]

{ #category : #accessing }
PIff >> rhs [
	^ rhs
]

{ #category : #accessing }
PIff >> rhs: anObject [
	rhs := anObject
]

{ #category : #'SMT interface' }
PIff >> smt2: γ [
	^(lhs smt2: γ) <=> (rhs smt2: γ)
]

Class {
	#name : #UncurriedApp,
	#superclass : #Object,
	#instVars : [
		'f',
		'args',
		'resultSort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
UncurriedApp class >> f: f args: args resultSort: rs [
	^self basicNew
		f: f;
		args: args;
		resultSort: rs;
		yourself
]

{ #category : #accessing }
UncurriedApp >> args [
	^ args
]

{ #category : #accessing }
UncurriedApp >> args: anObject [
	args := anObject
]

{ #category : #'as yet unclassified' }
UncurriedApp >> conjuncts [
	^{self}
]

{ #category : #accessing }
UncurriedApp >> f [
	^ f
]

{ #category : #accessing }
UncurriedApp >> f: anObject [
	f := anObject
]

{ #category : #'as yet unclassified' }
UncurriedApp >> isConc [
	^true
]

{ #category : #'as yet unclassified' }
UncurriedApp >> isTautoPred [
	^false
]

{ #category : #'as yet unclassified' }
UncurriedApp >> kvarsExpr [
	^#()
]

{ #category : #accessing }
UncurriedApp >> resultSort [
	^ resultSort
]

{ #category : #accessing }
UncurriedApp >> resultSort: anObject [
	resultSort := anObject
]

{ #category : #'SMT interface' }
UncurriedApp >> smt2: γ [
	| s D |
	s := f expr sym.
	D := args collect: #sort.
	f expr
		ifUninterpreted: [
			| α αc |
			α := γ naturalTransformations at: s.
			αc := α from: D to: resultSort in: γ.
			^αc valueWithArguments: (args collect: [ :eachArg | eachArg smt2: γ ] )
		] ifInterpreted: [ :aTheorySymbol |
			| smtD smtC smtArgs |
			self assert: aTheorySymbol tsSym = s.
			smtD := D collect: [ :each | each z3sort: γ ].
			smtArgs := args collect: [ :eachArg | eachArg smt2: γ ].
			(smtArgs zip: smtD) doAssociations: [ :eachArg :eachSort | self assert: eachArg sort == eachSort ].
			smtC := resultSort z3sort: γ.
			^aTheorySymbol tsInterp
				apply: s
				to: smtArgs
				ofZ3sorts: smtD
				returning: smtC
		] in: γ
]

{ #category : #'SMT interface' }
UncurriedApp >> smt2Cast: s in: γ [
	self assert: self resultSort = s.
	^self smt2: γ
	
]

{ #category : #sorting }
UncurriedApp >> sort [
	^UncurriedFFunc dom: (args collect: #sort) cod: resultSort
]

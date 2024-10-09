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
UncurriedApp >> smt2 [
	| s α D αc |
	s := f expr sym.
	α := (Context readState: #symbolEnv) naturalTransformations at: s.
	D := args collect: #sort.
	αc := α from: D to: resultSort.
	^αc valueWithArguments: (args collect: #smt2 )
]

{ #category : #'SMT interface' }
UncurriedApp >> smt2Cast: s [
	self assert: self resultSort = s.
	^self smt2
	
]

{ #category : #sorting }
UncurriedApp >> sort [
	^UncurriedFFunc dom: (args collect: #sort) cod: resultSort
]

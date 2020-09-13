"
The N Queens Problem, using the most-naive encoding.
"
Class {
	#name : #NQueensTest1,
	#superclass : #TestCase,
	#instVars : [
		'solver'
	],
	#category : #'MachineArithmetic-Tests'
}

{ #category : #running }
NQueensTest1 >> setUp [
	Z3Context createGlobalContext.
	solver := Solver new
]

{ #category : #solving }
NQueensTest1 >> solve: n [
	| columns rows m |
	columns := (1 to: n) collect: [ :i | Int var: 'col_', i printString ].
	rows :=    (1 to: n) collect: [ :i | Int var: 'row_', i printString ].
	"Now, Disctinct"
	solver assert: (solver ctx mkDistinct: columns).
	solver assert: (solver ctx mkDistinct: rows).
	1 to: n do: [ :i |
		solver assert: (columns at: i) >= 1.
		solver assert: (columns at: i) <= n.
		solver assert: (rows at: i) >= 1.
		solver assert: (rows at: i) <= n ].
	"No two queens should take each other"
	1 to: n-1 do: [ :i |
		i+1 to: n do: [ :j |
			solver assert: (
				((columns at: i) - (columns at: j)) abs
				eq:
				((rows at: i) - (rows at: j)) abs
			) not ]].
	solver check ifFalse: [^nil].
	m := solver getModel constants.
	^(1 to: n) collect: [ :i |
		(m at: (columns at: i) sym) asInteger @ (m at: (rows at: i) sym) asInteger  ].

]

{ #category : #running }
NQueensTest1 >> tearDown [
	solver del.
	Z3Context current del
]

{ #category : #tests }
NQueensTest1 >> test3 [
	self assert: (self solve: 3) isNil
]

{ #category : #tests }
NQueensTest1 >> test4 [
	self assert: (self solve: 4) isNotNil
]

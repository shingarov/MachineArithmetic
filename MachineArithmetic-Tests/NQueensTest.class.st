"
The N Queens Problem, using the most-naive encoding.
This is a very very far cry from CLP(FD) ff-labeling.
"
Class {
	#name : #NQueensTest,
	#superclass : #TestCase,
	#instVars : [
		'solver'
	],
	#category : #'MachineArithmetic-Tests'
}

{ #category : #running }
NQueensTest >> setUp [
	Z3Context createGlobalContext.
	solver := Solver new
]

{ #category : #solving }
NQueensTest >> solveLessNaive: n [
	| rows m |
	rows :=    (1 to: n) collect: [ :i | Int var: i ].
	solver assert: (solver ctx mkDistinct: rows).
	1 to: n do: [ :i |
		solver assert: (rows at: i) >= 1.
		solver assert: (rows at: i) <= n ].
	"No two queens should take each other"
	1 to: n-1 do: [ :i |
		i+1 to: n do: [ :j |
			solver assert: (
				((rows at: i) - (rows at: j)) abs
				eq:
				(i-j) abs
			) not ]].
	solver check ifFalse: [^nil].
	m := solver getModel constants.
	^(1 to: n) collect: [ :i |
		i @ (m at: (rows at: i) sym) asInteger  ].

]

{ #category : #solving }
NQueensTest >> solveNaive: n [
	| columns rows m |
	columns := (1 to: n) collect: [ :i | Int var: 'col_', i printString ].
	rows :=    (1 to: n) collect: [ :i | Int var: 'row_', i printString ].
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
NQueensTest >> tearDown [
	solver del.
	Z3Context current del
]

{ #category : #tests }
NQueensTest >> test3 [
	self assert: (self solveNaive: 3) isNil
]

{ #category : #tests }
NQueensTest >> test4 [
	self assert: (self solveNaive: 4) notNil

]

{ #category : #tests }
NQueensTest >> testLessNaive3 [
	self assert: (self solveLessNaive: 3) isNil
]

{ #category : #tests }
NQueensTest >> testLessNaive4 [
	self assert: (self solveLessNaive: 4) notNil

]

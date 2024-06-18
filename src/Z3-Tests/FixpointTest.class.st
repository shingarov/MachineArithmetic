Class {
	#name : #FixpointTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'fp'
	],
	#category : #'Z3-Tests'
}

{ #category : #'z3 context' }
FixpointTest >> setUp [
	super setUp.
	fp := Z3Fixedpoint new
		setParams: 'fp.engine' -> 'datalog';
		setParams: 'datalog.generate_explanations' -> true.
]

{ #category : #'z3 context' }
FixpointTest >> tearDown [
	fp release.
	super tearDown.
]

{ #category : #tests }
FixpointTest >> testBasicDatalog [
	| a b |
	a := 'a' toBool. b := 'b' toBool.
	fp registerRelation: a funcDecl.
	fp registerRelation: b funcDecl.
	fp fact: a.
	self assert: (fp query: {a}).
	self deny: (fp query: {b}).
	fp rule: nil head: b body: a.
	self assert: (fp query: {b}).	
]

{ #category : #tests }
FixpointTest >> testSimpleGraph [
	"See https://www.philipzucker.com/z3-rise4fun/fixedpoint.html"
	| s a b c edge path q1 q2 q3 answer |
	s := Z3Sort bv: 3.
	edge := 'edge' predicateOver: {s . s}.  fp registerRelation: edge.
	path := 'path' predicateOver: {s . s}.  fp registerRelation: path.

	a := 'a' toBitVector: 3. fp declareVar: a.
	b := 'b' toBitVector: 3. fp declareVar: b.
	c := 'c' toBitVector: 3. fp declareVar: c.

	fp fact: (edge value: 1///3 value: 2///3).
	fp fact: (edge value: 1///3 value: 3///3).
	fp fact: (edge value: 2///3 value: 4///3).
	
	fp rule: nil head: (path value: a value: b) body: (edge value: a value: b).
	fp rule: nil head: (path value: a value: c) body: (path value: a value: b)&(path value: b value: c).

	q1 := 'q1' predicateOver: {}.  fp registerRelation: q1.
	fp rule: nil head: q1 value body: (path value: 1///3 value: 4///3).
	q2 := 'q2' predicateOver: {}.  fp registerRelation: q2.
	fp rule: nil head: q2 value body: (path value: 3///3 value: 4///3).
	q3 := 'q3' predicateOver: {s}. fp registerRelation: q3.
	fp rule: nil head: (q3 value:b) body: (path value: 1///3 value: b).
	
	self assert: (fp query: {q1}).
	self deny: (fp query: {q2}).
	self assert: (fp query: {q3}).
	answer := fp getAnswer.
	self assert: answer isBool.
	self assert: answer functorName equals: 'or'.
	self assert: answer args size equals: 3.
]

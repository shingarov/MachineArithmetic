Class {
	#name : #FixpointTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
FixpointTest >> testBasicDatalog [
	| fp a b |
	fp := Z3Fixedpoint new
		setParams: 'fp.engine' -> 'datalog';
		setParams: 'datalog.generate_explanations' -> true.
	a := 'a' toBool. b := 'b' toBool.
	fp registerRelation: a funcDecl.
	fp registerRelation: b funcDecl.
	fp fact: a.
	self assert: (fp query: a).
	self deny: (fp query: b).
	fp rule: nil head: b body: a.
	self assert: (fp query: b).	
]

Class {
	#name : #FirstASPTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-ASP-Tests'
}

{ #category : #tests }
FirstASPTest >> test1 [ 
	| fs smt2 |
	smt2 := (FileReference / '/home/boris/work/EZSMT/SMT804458311') readStream contents.
	fs := Z3ASTVector parseSmtlib2String: smt2.
	
	
	self assert: (fs printString beginsWith: '(ast-vector')
]

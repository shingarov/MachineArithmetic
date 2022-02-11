Class {
	#name : #L1ExpressionTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
L1ExpressionTest >> testInt [
	| fortyTwo |
	fortyTwo := L1Expression int: 42.
	self assert: fortyTwo imm prim integer equals: 42
]

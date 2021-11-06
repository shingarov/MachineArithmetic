Class {
	#name : #NNFParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Fixpoint'
}

{ #category : #tests }
NNFParserTest >> parse: aString [
	self deny: (NNFParser parse: aString) isPetitFailure 
]

{ #category : #tests }
NNFParserTest >> testConstraintEmptyAnd [
	self parse: '
(constraint (and))
'
]

{ #category : #tests }
NNFParserTest >> testConstraintHead [
	self parse: '
(constraint (x>0))
'
]

{ #category : #tests }
NNFParserTest >> testConstraintWithAndHypothesis [
	self parse: '
(constraint (forall ((x Int) (and ($k0 xx y) ($k1 z))) (a=b)))
'
]

{ #category : #tests }
NNFParserTest >> testConstraintWithDecidableHypothesis [
	self parse: '
(constraint (forall ((x Int) ((x*3) < 1)) (a=b)))
'
]

{ #category : #tests }
NNFParserTest >> testConstraintWithVarAppConclusion [
	self parse: '
(constraint (forall ((x Int) (and)) (($k0 xx y))))
'
]

{ #category : #tests }
NNFParserTest >> testConstraintWithVarAppHypothesis [
	self parse: '
(constraint (forall ((x Int) ($k0 xx y)) (a=b)))
'
]

{ #category : #tests }
NNFParserTest >> testFixpoint [
	self parse: '
(fixpoint "--eliminate=horn")
(fixpoint "--rewrite")
(fixpoint "--fuel=5")
'
]

{ #category : #tests }
NNFParserTest >> testNestedAnd [
	self parse: '
(constraint (and (and) (and)))
'
]

{ #category : #tests }
NNFParserTest >> testVar [
	self parse: '
(var $k ((Int)))
(var $k0 ((Int)))
(var $k1 ((Int) (Int) (Int)))
(var $k2 ((Int) (Int) (Int)))
(var $k3 ((Int) (Int) (Int)))
(var $k_##1 ((Int)))
'
]

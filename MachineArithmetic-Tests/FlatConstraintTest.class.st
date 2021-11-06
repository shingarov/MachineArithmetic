Class {
	#name : #FlatConstraintTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Fixpoint'
}

{ #category : #tests }
FlatConstraintTest >> test1 [
	| src cstr flat |
	src := NNFParser parse: '
(constraint
  (forall ((VV##15 Int) (VV##15 == anf##3))
                    ((and (and
                      ($k13 VV##15 anf##3 moo##5)
                      (true))))))
'.
	cstr := src qCstr first.
	flat := cstr flatConstraint.
	
  "(forall ((VV##15 Int) (VV##15 == anf##3)) ((k13 VV##15 anf##3 moo##5)))"

	self assert: #()  isEmpty
]

{ #category : #tests }
FlatConstraintTest >> testEmpty [ 
	self assert: #() flatConstraint isEmpty
]

{ #category : #tests }
FlatConstraintTest >> testTwoEmptyAnds [
	| collection |
	collection := { 
		HPredAnd of: #().
		HPredAnd of: #(). }.
	self assert: collection flatConstraint size = 0
]

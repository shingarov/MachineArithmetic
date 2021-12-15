Class {
	#name : #FlatConstraintTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FlatConstraintTest >> test1 [
	| src cstr flat refVarApp |
	src := NNFParser parse: '(constraint
   (forall ((VV15 Int) (VV15 === anf3))
                    (and
                      (and
                        (($k13 VV15 anf3 moo5))
                        ((and))))))'.
	cstr := src qCstr first.
	flat := cstr flatConstraint.
	refVarApp := flat p "it's a head"
			pred. "it's a RefVarApp"
	self assert: refVarApp var equals: 'k13'.
	self assert: refVarApp arity equals: 3
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
	self assert: collection flatConstraint isEmpty
]

Class {
	#name : #'ΛβParserTest',
	#superclass : #TestCaseWithZ3Context,
	#category : #'Metalanguage-Tests-Parser'
}

{ #category : #tests }
ΛβParserTest >> testBracesConstrainedType [
	| rrty |
	rrty := (ΛβParser new productionAt: #rtype) end parse:
'{x::int, w::int<p> ⊢ int ≺: int}
   (y:''b => ''c<p y>)
=> (z:''a => ''b<q z>)
=>  x:''a
=> ''c<r x>'.
	self assert: (rrty isKindOf: RRTy_OCons).
]

{ #category : #tests }
ΛβParserTest >> testConstraint [
	| rrty |
	rrty := (ΛβParser new productionAt: #constraint) end parse: 'x::int, w::int<p> ⊢ int ≺: int'.
	self assert: (rrty isKindOf: RRTyConstraintRep)
]

{ #category : #tests }
ΛβParserTest >> testConstraintEnv [
	| assocs |
	assocs := (ΛβParser new productionAt: #constraintEnv) end parse: 'x::int, w::int ⊢'.
	self deny: assocs isPetitFailure.
	self deny: assocs isNil.
	self assert: assocs size = 2.
]

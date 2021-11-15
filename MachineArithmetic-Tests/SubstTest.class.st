Class {
	#name : #SubstTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Fixpoint'
}

{ #category : #tests }
SubstTest >> testCat1 [
	"Taken from a real LHF example"
	| θ1 θ2 cat |
	θ1 := Subst mkSubst: { 'nnf_arg' -> (EVar of: 'v1') }.
	θ2 := Subst mkSubst: { 'v1' -> (EVar of: 'v1__1') }.
	cat := θ1 cat: θ2.
	self assert: cat size equals: 2
]

{ #category : #tests }
SubstTest >> testCatEmpty [
	| θ1 θ2 cat |
	θ1 := Subst mkSubst: { 'x' -> (EVar of: 'y') }.
	θ2 := Subst mkSubst: #().
	self assert: θ2 isEmpty.
	cat := θ1 cat: θ2.
	self assert: cat size equals: 1.
	self assert: cat equals: θ1
]

{ #category : #tests }
SubstTest >> testCatSame [
	| θ1 θ2 cat |
	θ1 := Subst mkSubst: { 'x' -> (EVar of: 'y') }.
	θ2 := Subst mkSubst: { 'x' -> (EVar of: 'y') }.
	self assert: θ1 equals: θ2.
	cat := θ1 cat: θ2.
	self assert: cat size equals: 1.
	self assert: cat equals: θ1.
	self assert: cat equals: θ2.
]

{ #category : #tests }
SubstTest >> testEqualSubst [
	| θ1 θ2 |
	θ1 := Subst mkSubst: { 'x' -> (EVar of: 'y') }.
	θ2 := Subst mkSubst: { 'x' -> (EVar of: 'y') }.
	self assert: θ1 equals: θ2
]

{ #category : #tests }
SubstTest >> testMkSubst [
	| list θ |
	list := { 
		'x' -> (EVar of: 'y').
		'z' -> (EVar of: 'z').
	 }.
	θ := Subst mkSubst: list.
	self deny: θ isEmpty.
	self assert: θ size equals: 1
]

{ #category : #tests }
SubstTest >> testOneSuka [
	| k xs oneSuka |
	k := 'k'.
	xs := #('y').
	oneSuka := k oneSuka: xs.
	self assert: oneSuka size equals: 1.
	self assert: oneSuka first key equals: 'kkargßkº1'.
	self assert: oneSuka first value varName equals: 'y'.
]

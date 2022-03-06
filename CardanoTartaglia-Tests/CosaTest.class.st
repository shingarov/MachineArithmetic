Class {
	#name : #CosaTest,
	#superclass : #TestCase,
	#category : #'CardanoTartaglia-Tests'
}

{ #category : #tests }
CosaTest >> testCosaInEnvironment [
	| a env |
	a := TartagliaContext evaluate: 'a'.
	self assert: a name equals: 'a'.
	
	env := Dictionary new at: 'a' put: 'asdf'; yourself.
	self assert: (a substCosas: env) equals: 'asdf'
	
]

{ #category : #tests }
CosaTest >> testCreateComparison [
	| x y lt |
	x := 'x' cosa.
	y := 'y' cosa.
	lt := x < y.
	self assert: lt functor equals: #<.
	self assert: lt arguments first name equals: 'x'.
	self assert: lt arguments last  name equals: 'y'
]

{ #category : #tests }
CosaTest >> testCreatePlus [
	| x y lt |
	x := 'x' cosa.
	y := 'y' cosa.
	lt := x + y.
	self assert: lt functor equals: #+.
	self assert: lt arguments first name equals: 'x'.
	self assert: lt arguments last  name equals: 'y'
]

{ #category : #tests }
CosaTest >> testEvaluateTartaglia [
	| lt |
	lt := TartagliaContext evaluate: 'a < b'.
	self assert: lt arguments first name equals: 'a'.
	self assert: lt arguments last  name equals: 'b'
]

{ #category : #tests }
CosaTest >> testPlus1InEnvironment [
	| expr env |
	expr := TartagliaContext evaluate: 'a+1'.
	self assert: expr functor equals: #+.
	
	env := Dictionary new
		at: 'a' put: 3;
		at: 'b' put: 4;
	 yourself.
	self assert: (expr substCosas: env) equals: 4
]

{ #category : #tests }
CosaTest >> testPlusInEnvironment [
	| expr env |
	expr := TartagliaContext evaluate: 'a+b'.
	self assert: expr functor equals: #+.
	
	env := Dictionary new
		at: 'a' put: 3;
		at: 'b' put: 4;
	 yourself.
	self assert: (expr substCosas: env) equals: 7
]

{ #category : #tests }
CosaTest >> testVariablesUnion [
	| lt |
	lt := TartagliaContext evaluate: 'a < a'.
	self assert: lt variables equals: (Set with: 'a')
]

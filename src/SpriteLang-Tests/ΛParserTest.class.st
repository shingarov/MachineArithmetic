Class {
	#name : #'ΛParserTest',
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Parser'
}

{ #category : #tests }
ΛParserTest >> testAnnDecl [
	| program |
	program := ΛκParser new end parse: '
⟦val x : int [v|v===42]⟧
let x = 42;
'.
	self deny: program isPetitFailure.

	self assert:  program quals isEmpty.
	self assert:  program meas  isEmpty.
	self assert: (program expr  isKindOf: ΛExpression).
	self assert:  program data  isEmpty.
]

{ #category : #tests }
ΛParserTest >> testAnnDecls [
	| program |
	program := ΛκParser new end parse: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val abs : x:int => int[?]⟧
let abs = (x) => {
  let pos = x >= 0;
  if (pos) {
    x
  } else {
    0 - x
  }
};

⟦val incf: int => int⟧
let incf = (z) => {
  ⟦val wrap : (int => int[?]) => int[?]⟧
  let wrap = (f) => {
    let r = f(z);
    r + 1
  };
  let res = wrap(abs);
  let ok  = 0 <= res;
  cassert (ok)
};
'.
	self deny: program isPetitFailure.

	self assert:  program quals isEmpty.
	self assert:  program meas  isEmpty.
	self assert: (program expr  isKindOf: ΛExpression).
	self assert:  program data  isEmpty.
]

{ #category : #tests }
ΛParserTest >> testMeasures [
	| program |
	program := ΛκParser new end parse: '
⟦measure len : list(''a) => int⟧

⟦val x : int [v|v===42]⟧
let x = 42;
'.
	self deny: program isPetitFailure.

	self assert:  program quals isEmpty.
	self assert:  program meas size equals: 1.
	self assert: (program expr  isKindOf: ΛExpression).
	self assert:  program data  isEmpty.
]

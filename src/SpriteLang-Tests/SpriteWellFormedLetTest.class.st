Class {
	#name : #SpriteWellFormedLetTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteWellFormedLetTest >> test_eann_pos [
	self proveSafe: '

⟦val fortyTwo: int => int[v|v === 42]⟧
let fortyTwo = (x) => {
  let t = 42;
  t
};

'
]

{ #category : #tests }
SpriteWellFormedLetTest >> test_eapp_pos [
	self proveSafe: '

let fortyTwo = 41 + 1;

'
]

{ #category : #tests }
SpriteWellFormedLetTest >> test_efun_crash [
	self should: [ self proveSafe: '

let fortyTwo = (x) => {
  let t = 42;
  t
};
'
	] raise: Error
]

{ #category : #tests }
SpriteWellFormedLetTest >> test_eimm_pos [
	self proveSafe: '

let fortyTwo = 42;

'
]

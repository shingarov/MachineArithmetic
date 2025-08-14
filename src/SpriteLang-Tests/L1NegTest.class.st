Class {
	#name : #L1NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L1NegTest >> test1 [
	self processString: '
⟦val x : int [v|v===42]⟧
let x = 111;
'
]

{ #category : #tests }
L1NegTest >> test3 [
	self processString: '
⟦val v1 : int⟧
let v1 = 1;

⟦val v2 : int [x|x===1]⟧
let v2 = v1;
'
]

{ #category : #tests }
L1NegTest >> test6 [
	self processString: '
⟦val annihilate: x:int => int[v | v === 0]⟧
let annihilate = (x) => { 
    x * 5
};
'
]

{ #category : #tests }
L1NegTest >> test7 [
	self processString: '
⟦val double: x:int => int[v | v === (x*3)]⟧
let double = (x) => {
   x + x
};
'
]

{ #category : #tests }
L1NegTest >> test_inc00 [
	self processString: '
⟦val inc: x:int => int[v|v === (x + 1)]⟧
let inc = (x) => {
    x - 1
};

let bar = inc(10);
'
]

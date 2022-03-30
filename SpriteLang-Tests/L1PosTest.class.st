Class {
	#name : #L1PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-simple' }
L1PosTest >> test1 [
	self processString: '
⟦val x : int [v|v===42]⟧
let x = 42;
'
]

{ #category : #'tests-simple' }
L1PosTest >> test2 [
	self processString: '
let v1 = 1;
let v2 = v1;
'
]

{ #category : #'tests-simple' }
L1PosTest >> test3 [
	self processString: '
let v1 = 1;

⟦val v2 : int [x|x===1]⟧
let v2 = v1;
'
]

{ #category : #'tests-simple' }
L1PosTest >> test4 [
	self processString: '
let v1 = 1;
let v2 = 2;
⟦val top : int[v|v === 3]⟧
let top = v1 + v2;
'
]

{ #category : #'tests-simple' }
L1PosTest >> test5 [
	self processString: '
⟦val annihilate: x:int => int[v | v === 0]⟧
let annihilate = (x) => { 
    x - x 
};
'
]

{ #category : #'tests-simple' }
L1PosTest >> test6 [
	self processString: '
⟦val double: x:int => int[v | v === (x*2)]⟧
let double = (x) => { 
    x + x
};
'
]

{ #category : #'tests-simple' }
L1PosTest >> test7 [
	self processString: '
⟦val double: x:int => int[v | v === (x*3)]⟧
let double = (x) => {
   let xx = x + x;
   xx + x
};
'
]

{ #category : #'tests-safety' }
L1PosTest >> test_inc00 [
	self processString: '
⟦val inc: x:int => int[v|v === (x + 1)]⟧
let inc = (x) => {
    x + 1
};

let bar = inc(10);
'
]

{ #category : #'tests-safety' }
L1PosTest >> test_inc01 [
	self processString: '
⟦val inc: x:int => int[v | v === (x+1)]⟧
let inc = (x) => { 
    x + 1 
};

⟦val inc2: x:int[v|0<=v] => int[v|0<=v]⟧
let inc2 = (x) => { 
    let tmp = inc(x);
    inc(tmp)
};
'
]

{ #category : #'tests-safety' }
L1PosTest >> test_int00 [
	self processString: '
let v1 = 1;
let v2 = 2;
let top = v1 + v2;
'
]

{ #category : #'tests-safety' }
L1PosTest >> test_int01 [
	self processString: '
let v1 = 1;
let v2 = 2;
⟦val top : int[v|v === 3]⟧
let top = v1 + v2;
'
]

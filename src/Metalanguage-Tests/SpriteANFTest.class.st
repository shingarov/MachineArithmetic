Class {
	#name : #SpriteANFTest,
	#superclass : #SpriteLangTest,
	#category : #'Metalanguage-Tests'
}

{ #category : #running }
SpriteANFTest >> parserClass [
	^ΛοParser
]

{ #category : #tests }
SpriteANFTest >> test_ANF_01 [
	self proveSafe: '
⟦val f : x:int => int[v|v === (x+1)]⟧
let f = (x) => {
  x + 1
};

⟦val g : x:int => int[v|v === (x+1)]⟧
let g = (x) => {
  x + 1
};

⟦val main : x:int => int[v|v === (x+2)]⟧
let main = (x) => {
  let result = f(g(x));
  result
};
'
]

{ #category : #tests }
SpriteANFTest >> test_ANF_02 [
	self proveSafe: '
⟦val f : x:int => int[v|v === (x+1)]⟧
let f = (x) => {
  x + 1
};

⟦val g : x:int => int[v|v === (x+x)]⟧
let g = (x) => {
  x + x
};

⟦val main : x:int => int[v|v === (x*2+3)]⟧
let main = (x) => {
  let result = f(g(f(x)));
  result
};
'
]

{ #category : #tests }
SpriteANFTest >> test_abs00_ANF [
	"Like L2 abs00, but the cond of EIf needs more than 0 steps to compute"
	self proveSafe: '
⟦val abs : x:int => int[v|0<=v]⟧
let abs = (x) => {
    if (x >= 0) {
        x
    } else {
        0 - x
    }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_abs00_ANF2 [
	"This will do in lieu of test_abs00_ANF until we fix Issue#536."
	self proveSafe: '
⟦val ge0 : x:int => bool[b|b <=> (0 <= x)]⟧
let ge0 = (x) => {
    x >= 0
};
	
⟦val abs : x:int => int[v|0<=v]⟧
let abs = (x) => {
    if (ge0(x)) {
        x
    } else {
        0 - x
    }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_app_app [
	self proveSafe: '
⟦val g : int => int[v|v === 42]⟧
let g = (x) => {
  42
};

⟦val f : x:int => y:int => int[v|v === (x+y)]⟧
let f = (x, y) => {
  x + y
};

⟦val main : int => int[v|v === 84]⟧
let main = (x) => {
  f(g(0), g(0))
};
'
]

{ #category : #tests }
SpriteANFTest >> test_app_let [
	self proveSafe: '
⟦val inc : x:int => int[v|v===(x+1)]⟧
let inc = (x) => {
  x + 1
};
	
⟦val main : x:int => int[v|v===43]⟧
let main = (arg) => {
    inc(let t = 42; t)
};
'
]

{ #category : #tests }
SpriteANFTest >> test_app_letlet [
	self proveSafe: '
⟦val inc : x:int => int[v|v===(x+1)]⟧
let inc = (x) => {
  x + 1
};
	
⟦val main : x:int => int[v|v===43]⟧
let main = (arg) => {
    inc(let s = 42; let t = s; t)
};
'
]

{ #category : #tests }
SpriteANFTest >> test_app_letletpbin [
	self proveSafe: '
⟦val inc : x:int => int[v|v===(x+1)]⟧
let inc = (x) => {
  x + 1
};
	
⟦val main : x:int => int[v|v===8]⟧
let main = (arg) => {
    inc(let s = 3; let t = 4; s + t)
};
'
]

{ #category : #tests }
SpriteANFTest >> test_app_pbin [
	self proveSafe: '
⟦val inc : x:int => int[v|v===(x+1)]⟧
let inc = (x) => {
  x + 1
};

⟦val incsum : x:int => y:int => int[v|v===(x+y+1)]⟧
let incsum = (x,y) => {
    inc(x + y)
};
'
]

{ #category : #tests }
SpriteANFTest >> test_if_let [
	self proveSafe: '
⟦val ge0 : x:int => bool[b|b <=> (0 <= x)]⟧
let ge0 = (x) => {
    x >= 0
};
	
⟦val abs : x:int => int[v|0<=v]⟧
let abs = (x) => {
    if (ge0(x)) {
        x
    } else {
        0 - x
    }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_if_let_02 [
	self proveSafe: '
⟦val abs : x:int => int[v|x===v]⟧
let abs = (x) => {
    if (let b = true; let i = 1; b) {
        x
    } else {
        0 - x
    }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_mutual_01 [
	self proveSafe: '
⟦reflect f: int => int⟧
let f = (x) => {
	g(x - 1)
};

⟦reflect g: int => int⟧
let g = (x) => {
	if (x == 0) {
		0
	} else {
		f(x)
	}
};
'
]

{ #category : #tests }
SpriteANFTest >> test_plain_if_01 [
	self proveSafe: '
⟦val ge0 : x:int => bool[b|b <=> (0 <= x)]⟧
let ge0 = (x) => {
    x >= 0
};
	
⟦val abs : x:int => int[v|0<=v]⟧
let abs = (x) => {
    let pos = ge0(x);
    if (pos) {
        x
    } else {
        0 - x
    }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_plain_if_02 [
	self proveSafe: '
⟦val main : x:int => int[v|v===1]⟧
let main = (x) => {
    if (true) { 1 } else { 2 }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_switch_01 [
	self proveSafe: '
type a_or_b =
  | A (bool)
  | B (int)
  ;

⟦val is_a : a_or_b => bool⟧
let is_a = (x) => {
  switch(x){
    | A(i) => true
    | B(j) => false
  }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_switch_02 [
	self proveSafe: '
type a_or_b =
  | A (b:bool) => [v|v === (A value: b)]
  | B (i:int) => [v|v === (B value: i)]
  ;

⟦val is_a : a_or_b => bool[b|b]⟧
let is_a = (x) => {
  switch(A(false)){
    | A(i) => true
    | B(j) => false
  }
};
'
]

{ #category : #tests }
SpriteANFTest >> test_switch_03 [
	self proveSafe: '
type i_or_b =
  | I (x:int)     => [v| v === (I value: x) ]
  | B (a:bool)    => [v| v === (B value: a) ]
  ;

⟦val main: x:int => int[v|v === (x+x)]⟧
let main = (x) => {
	let x = x + x;
	switch (I(x)) {
    | I(x) => x
    | B(x) => 0
	}
};
'

]

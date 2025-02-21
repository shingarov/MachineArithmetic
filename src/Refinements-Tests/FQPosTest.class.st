Class {
	#name : #FQPosTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQPosTest >> testADT [
	self provePos: '
data Vec 1 = [
  | mkNil  { }
  | mkCons { head : @(0), tail : Vec @(0)}
]

bind 1 x  : {x : int | Bool true}
bind 2 y  : {y : int | Bool true}
bind 3 xs : {xs : Vec int | xs === mkNil value }
bind 4 ys : {ys : Vec int | Bool true}
bind 5 l1 : {l1 : Vec int | l1 === (mkCons value: x value: xs) }
bind 6 l2 : {l2 : Vec int | l2 === (mkCons value: y value: ys) }
bind 7 l3 : {l3 : Vec int | Bool true }

constraint:
  env [1;2;3;4;5;6]
  lhs {v : int | l1 === l2 }
  rhs {v : int | x === y }
  id 1 tag []

constraint:
  env [1;2;3;4;5;6]
  lhs {v : int | l1 === l2 }
  rhs {v : int | xs === ys }
  id 2 tag []

constraint:
  env [1;3;5;7]
  lhs {v : int | l1 === l3  }
  rhs {v : int | (isß36ßmkCons value: l3) }
  id 3 tag []

constraint:
  env [1;3;5;7]
  lhs {v : int | l1 === l3 }
  rhs {v : int | x === (head value: l3) }
  id 4 tag []

constraint:
  env [1;3;5;7]
  lhs {v : int | l1  === l3 }
  rhs {v : int | mkNil value === (tail value: l3) }
  id 5 tag []
'.


]

{ #category : #tests }
FQPosTest >> testAdtBin0 [
	self provePos: '
constant prop   : func(2, [@(0); @(1)])
constant gibber : func(0, [int; int; int])

data Bin 0 = [
  | mkBin { nBin : Int }
]

data Binary 0 = [
  | mkB0 { }
  | mkB1 { }
]

bind 0 n : {n:Int | (gibber value: 2 value: 3) === 4 }
bind 1 p : {p:Binary | prop∘p === (mkBin∘n) & (prop∘p === (mkBin∘0))}
bind 2 p : {p:Binary | prop∘p === (mkBin∘n) & (prop∘p === (mkBin∘1))}

constraint:
  env [0; 1]
  lhs {v:int | Bool true}
  rhs {v:int | n === 0 | (n === 1)}
  id 1 tag []

constraint:
  env [0; 2]
  lhs {v:int | Bool true}
  rhs {v:int | n === 0 | (n === 1)}
  id 2 tag []
'.


]

{ #category : #tests }
FQPosTest >> testAdtDep0 [
	self provePos: '
data Zob 0 = [
  | boo { choo : int }
]

data LL 0 = [
  | emp { }
  | con { lHead : Zob, lTail : LL }
]

constraint:
  env []
  lhs {v:int | Bool true }
  rhs {v:int | emp === ((1 toInt < 2) ifTrue: emp ifFalse: emp) }
  id 1 tag []
'.


]

{ #category : #tests }
FQPosTest >> testAdtDep1 [
	self provePos: '
data LL 0 = [
  | emp { }
  | con { lHead : Bob, lTail : LL }
]

data Bob 0 = [
  | boo { choo : int }
]

constraint:
  env []
  lhs {v:int | Bool true }
  rhs {v:int | emp === ((1 toInt < 2) ifTrue: emp ifFalse: emp) }
  id 1 tag []
'.


]

{ #category : #tests }
FQPosTest >> testAdtFunc0 [
	self provePos: '
data Boo 0 = [
  | bling { booFirst : func(0, [int; int]) }
]

constant booFirst : func(0, [Boo; int; int])

bind 1 x  : {v : Boo | Bool true}
bind 2 y  : {v : Boo | v === x}

constraint:
  env [1;2]
  lhs {v : int | (booFirst value: x value: 0) === 10 }
  rhs {v : int | (booFirst value: y value: 0) === 10 }
  id 1 tag []
'.


]

{ #category : #tests }
FQPosTest >> testAdtMutrec [
	self provePos: '
data Val 0 = [
  | VClos { vc1 : int, vc2 : int, vc3 : int, vc4 : VEnv}
  | VInt  { vi1 : int }
  ]

data VEnv 0 = [
  | VEmp  { }
  | VBind { vb1 : int, vb2 : Val, vb3 : VEnv}
  ]

bind 1 env  : {v : VEnv | Bool true }
bind 2 val  : {v : Val  | Bool true }
bind 3 x    : {v : int  | Bool true }
bind 4 y    : {v : int  | Bool true }
bind 5 envx : {v : VEnv | v === (VBind value: x value: val value: env) }
bind 6 envy : {v : VEnv | v === (VBind value: y value: val value: env) }

constraint:
  env [1;2;3;4;5;6]
  lhs {v: int | x === y}
  rhs {v: int | envx === envy}
  id 1 tag []
'.


]

{ #category : #tests }
FQPosTest >> testCoerce2a [
	self provePos: '
bind 1 b   : { v: int | Bool true }
bind 2 pig : { v: `b   | v === 10 }

constraint:
  env [1;2]
  lhs {v : int | Bool true }
  rhs {v : int | pig > 5}
  id 1 tag []
'.


]

{ #category : #tests }
FQPosTest >> testCoerce2b [
	self provePos: '

constant len : (func(2, [(@(0)  @(1)); int]))

bind 1 b   : { v: int | Bool true }
bind 2 pig : { v: `b   | v === 10 }

constraint:
  env [1;2]
  lhs {v : int | Bool true }
  rhs {v : int | pig > 5}
  id 1 tag []
'.


]

{ #category : #tests }
FQPosTest >> testConjRhs [
	self provePos: '
constraint:
  env []
  lhs {v:int | Bool true }
  rhs {v:int | ((0 toInt < 1) & (1 toInt > 0)) }
  id 1
  tag [1]
'
]

{ #category : #tests }
FQPosTest >> testEqConstr0 [
	self provePos: '
bind 0 a : {v: int | Bool true }
bind 1 x : {v: int | Bool true }
bind 2 y : {v: `a | Bool true }

constraint:
  env [0; 1; 2]
  lhs {v:int | x === y }
  rhs {v:int | y === x }
  id 1
  tag [1]
'
]

{ #category : #tests }
FQPosTest >> testEqConstr1 [
	self provePos: '
data Thing 0 = [
  | Cons {Head : int}
]

bind 0 a : {v: Thing | Bool true }
bind 1 x : {v: Thing | Bool true }
bind 2 y : {v: `a    | Bool true }

constraint:
  env [0; 1; 2]
  lhs {v:int | x === y }
  rhs {v:int | y === x }
  id 1 tag []
'.


]

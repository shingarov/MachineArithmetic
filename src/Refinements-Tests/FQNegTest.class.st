Class {
	#name : #FQNegTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQNegTest >> testAdt0 [
	self proveNeg: '
data Vec 1 = [
  | mkNil  { }
  | mkCons { head : @(0), tail : Vec @(0)}
]

bind 1 x  : {v : int | Bool true}
bind 2 y  : {v : int | Bool true}
bind 3 xs : {v : Vec int | Bool true}
bind 4 ys : {v : Vec int | Bool true}
bind 5 l1 : {v : Vec int | v === (mkCons value: x value: xs) }
bind 6 l2 : {v : Vec int | v === (mkCons value: y value: ys) }
bind 7 l3 : {v : Vec int | Bool true }

constraint:
  env [1;2;3;4;5;6]
  lhs {v : int | Bool true }
  rhs {v : int | x === y }
  id 1 tag []
'
]

{ #category : #tests }
FQNegTest >> testAdt1 [
	self proveNeg: '
data Vec 1 = [
  | mkNil  { }
  | mkCons { head : @(0), tail : Vec @(0)}
]

bind 1 x  : {v : int | Bool true}
bind 2 y  : {v : int | Bool true}
bind 3 xs : {v : Vec int | v === mkNil }
bind 4 ys : {v : Vec int | Bool true}
bind 5 l1 : {v : Vec int | v === (mkCons value: x value: xs) }
bind 6 l2 : {v : Vec int | v === (mkCons value: y value: ys) }
bind 7 l3 : {v : Vec int | Bool true }

constraint:
  env [1;3;5;7]
  lhs {v : int | Bool true  }
  rhs {v : int | isß36ßmkCons ∘ l3 }
  id 3 tag []

constraint:
  env [1;3;5;7]
  lhs {v : int | l1 === l3 }
  rhs {v : int | x === (head ∘ l3) }
  id 4 tag []

constraint:
  env [1;3;5;7]
  lhs {v : int | l1  === l3 }
  rhs {v : int | mkNil === (tail ∘ l3) }
  id 5 tag []
'
]

{ #category : #tests }
FQNegTest >> testAdt2 [
	self proveNeg: '
data Vec 1 = [
  | mkNil  { }
  | mkCons { head : @(0), tail : Vec @(0) }
]

bind 1 x  : {v : int | Bool true}
bind 2 y  : {v : int | Bool true}
bind 3 xs : {v : Vec int | v === mkNil }
bind 4 ys : {v : Vec int | Bool true}
bind 5 l1 : {v : Vec int | v === (mkCons value: x value: xs) }
bind 6 l2 : {v : Vec int | v === (mkCons value: y value: ys) }
bind 7 l3 : {v : Vec int | Bool true }

constraint:
  env [1;3;5;7]
  lhs {v : int | l1 === l3 }
  rhs {v : int | y === (head ∘ l3) }
  id 4 tag []
'
]

{ #category : #tests }
FQNegTest >> testAdt3 [
	self proveNeg: '
data Vec 1 = [
  | mkNil  { }
  | mkCons { head : @(0), tail : Vec @(0)}
]

bind 1 x  : {v : int | Bool true}
bind 2 y  : {v : int | Bool true}
bind 3 xs : {v : Vec int | Bool true }
bind 4 ys : {v : Vec int | Bool true}
bind 5 l1 : {v : Vec int | v === (mkCons value: x value: xs) }
bind 6 l2 : {v : Vec int | v === (mkCons value: y value: ys) }
bind 7 l3 : {v : Vec int | Bool true }

constraint:
  env [1;3;5;7]
  lhs {v : int | l1  === l3 }
  rhs {v : int | mkNil === (tail ∘ l3) }
  id 5 tag []
'
]

{ #category : #tests }
FQNegTest >> testAdtBin0 [
	self proveNeg: '
constant prop : func(2, [@(0); @(1)])
constant gibber : func(0, [int; int; int])

data Bin 0 = [
  | mkBin { nBin : Int }
]

data Binary 0 = [
  | mkB0 { }
  | mkB1 { }
]

bind 0 n : {n:Int | (gibber value: 2 value: 3) === 4 }
bind 1 p : {p:Binary | (prop∘p) === (mkBin∘n)  & ( (prop∘p) === (mkBin∘0) )}
bind 2 p : {p:Binary | (prop∘p) === (mkBin∘n)  & ( (prop∘p) === (mkBin∘1) )}

constraint:
  env [0; 1]
  lhs {v:int | Bool true}
  rhs {v:int | (n===0) | (n===1)}
  id 1 tag []

constraint:
  env [0; 2]
  lhs {v:int | Bool true}
  rhs {v:int | n===0 }
  id 2 tag []
'
]

{ #category : #tests }
FQNegTest >> testAdtEven0 [
	self proveNeg: '
constant prop   : func(2, [@(0); @(1)])

data Peano 0 = [
  | mkZ { }
  | mkS { cS0 : Peano }
]

data Ev 0 = [
  | mkEv { cEv0 : Peano }
]

data Even 0 = [
  | mkEZ  { }
  | mkESS { cESS0 : Peano, cESS1 : Even }
]

bind 0 n : {n:Peano | Bool true}
bind 1 p : {p:Even  | prop∘p === (mkEv∘(mkS∘(mkS∘n))) & (prop∘p === (mkEv∘mkZ))}
bind 2 m : {m:Peano | Bool true}
bind 3 q : {q:Even  | prop∘q === (mkEv∘m) }
bind 4 p : {p:Even  | prop∘p === (mkEv∘(mkS∘(mkS∘n))) & (prop∘p === (mkEv∘(mkS∘(mkS∘m))))}

constraint:
  env [0;1]
  lhs {v:Even | Bool true}
  rhs {v:Even | prop∘v === (mkEv∘n)}
  id 1 tag []

constraint:
  env [0;2;3;4]
  lhs {v:Even | Bool true }
  rhs {v:Even | prop∘v === (mkEv∘n)}
  id 2 tag []
'
]

{ #category : #tests }
FQNegTest >> testAdtMutrec [
	self proveNeg: '
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
  lhs {v: int | Bool true}
  rhs {v: int | envx === envy}
  id 1 tag []
'.
]

{ #category : #tests }
FQNegTest >> testConjRhs [
	self proveNeg: '
constraint:
  env []
  lhs {v:int | Bool true }
  rhs {v:int | ((0 toInt < 1) & (1 toInt < 0)) }
  id 1
  tag [1]
'
]

{ #category : #tests }
FQNegTest >> testSets01 [
	self proveNeg: '
bind 1 m1 : {v : Set_Set Int | v === (Set_empty∘0) }
bind 2 m2 : {v : Set_Set Int | v === (Set_cup value: (Set_cup value: m1 value: Set_sng∘10) value: Set_sng∘20) }
bind 3 m3 : {v : Set_Set Int | v === (Set_cup value: (Set_cup value: m1 value: Set_sng∘20) value: Set_sng∘10) }
bind 4 m4 : {v : Set_Set Int | v === (Set_cup value: m1 value: Set_sng∘10) }
bind 5 m5 : {v : Set_Set Int | v === (Set_cup value: m1 value: Set_sng∘20) }

constraint:
  env [1]
  lhs {v : int | Bool true }
  rhs {v : int | (Set_mem value: 100 value: m1) }
  id 1 tag []

constraint:
  env [1;2]
  lhs {v : int | Bool true }
  rhs {v : int | (Set_mem value: 100 value: m2) not }
  id 2 tag []

constraint:
  env [1;2]
  lhs {v : int | Bool true }
  rhs {v : int | Set_mem value: 10 value: m2 }
  id 3 tag []

constraint:
  env [1;2;3]
  lhs {v : int | Bool true }
  rhs {v : int | m2 === m3 }
  id 4 tag []

constraint:
  env [1;2;3;4;5]
  lhs {v : int | Bool true }
  rhs {v : int | m2 === (Set_cup value: m4 value: m5) }
  id 5 tag []
'.
]

{ #category : #tests }
FQNegTest >> testTest00a [
	self proveNeg: '
qualif Zog(v:`a) : (10 <= v)

bind 0 x : {v : int | Bool true}
bind 1 y : {v : int | Bool true}
bind 2 z : {v : int | Bool true}

constraint:
  env [0]
  lhs {v : int | (x === 9)}
  rhs {v : int | $k0[v:=x]}
  id 1 tag []

constraint:
  env [1]
  lhs {v : int | y === 20}
  rhs {v : int | $k0[v:=y]}
  id 2 tag []

constraint:
  env [2]
  lhs {v : int | $k0[v:=z]}
  rhs {v : int | 10 toInt <= z}
  id 3 tag []

wf:
  env []
  reft {v: int | $k0}
'
]

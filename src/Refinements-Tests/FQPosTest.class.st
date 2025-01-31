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

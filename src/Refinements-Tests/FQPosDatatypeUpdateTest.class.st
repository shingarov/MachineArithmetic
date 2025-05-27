Class {
	#name : #FQPosDatatypeUpdateTest,
	#superclass : #FQPosTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQPosDatatypeUpdateTest >> testUpdateField1 [
	self provePos: '
data Point 0 = [
  | point { x : int, y : int }
]

bind 1 p1 : {p1:Point | p1 === (point value: 42 value: 43)}
bind 2 p2 : {p2:Point | p2 === (updateß36ßx value: p1 value: 1)}

constraint:
  env [1;2]
  lhs {v:int | Bool true }
  rhs {v:int | x∘p2 === 1 }
  id 1 tag []
'.


]

{ #category : #tests }
FQPosDatatypeUpdateTest >> testUpdateField2 [
	self provePos: '
data Point 0 = [
  | point { x : int, y : int }
]

bind 1 p1 : {p1:Point | p1 === (point value: 42 value: 43)}
bind 2 p2 : {p2:Point | p2 === (updateß36ßx value: p1 value: 1)}

constraint:
  env [1;2]
  lhs {v:int | Bool true }
  rhs {v:int | y∘p1 === 43 }
  id 1 tag []
'.


]

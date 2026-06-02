Class {
	#name : #SpriteIssue616Test,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteIssue616Test >> test_complex_expr_1 [
	self processString: '
⟦val ificmpge : c1:int => c2:int => bool[v|v === (c1 >= c2)]⟧	
 let ificmpge = (c1,c2) => {
		c1 >= c2
 };	
	
⟦val check01 : bool[b|b]⟧	
 let check01 = {
	let one = 1;
	ificmpge(one, one)
 };
'
]

{ #category : #tests }
SpriteIssue616Test >> test_complex_expr_2 [
	self processString: '
⟦val ificmpge : c1:BitVec(Size32) => c2:BitVec(Size32) => bool[v|v === (c1 >= c2)]⟧	
 let ificmpge = (c1,c2) => {
		bvsge(c1 , c2)
 };	
	
⟦val check01 : bool[b|b]⟧	
 let check01 = {
	let one = toBitVector(1);
	ificmpge(one, one)
 };
'
]

{ #category : #tests }
SpriteIssue616Test >> test_complex_expr_2b [
	self processString: '
⟦val ificmpge : c1:BitVec(Size32) => c2:BitVec(Size32) => bool[v|v === (c1 >= c2)]⟧	
 let ificmpge = (c1,c2) => {
		bvsge(c1 , c2)
 };	
'
]

{ #category : #tests }
SpriteIssue616Test >> test_complex_expr_3f [
	self processString: '
⟦val ificmpge : c1:BitVec(Size32) => c2:BitVec(Size32) => bool[v|v === ((c1 >= c2) & Bool false)]⟧	
 let ificmpge = (c1,c2) => {
		false
 };	
'
]

{ #category : #tests }
SpriteIssue616Test >> test_complex_expr_3t [
	self processString: '
⟦val ificmpge : c1:BitVec(Size32) => c2:BitVec(Size32) => bool[v|v === ((c1 >= c2) | Bool true)]⟧	
 let ificmpge = (c1,c2) => {
		true
 };	
'
]

{ #category : #tests }
SpriteIssue616Test >> test_complex_expr_4t [
	self processString: '
⟦val ificmpge : c1:BitVec(SizeXX) => c2:BitVec(Size32) => bool[v|v === ((c1 >= c2) | Bool true)]⟧	
 let ificmpge = (c1,c2) => {
		true
 };	
'
]

{ #category : #tests }
SpriteIssue616Test >> test_complex_expr_5 [
	self processString: '
⟦val ificmpge : c1:BitVec(Size32) => c2:BitVec(Size32) => bool[v|v === (c1 === c2)]⟧	
 let ificmpge = (c1,c2) => {
		bveq(c1 , c2)
 };	
	
⟦val check01 : bool[b|b]⟧	
 let check01 = {
	let one = toBitVector(1);
	ificmpge(one, one)
 };
'
]

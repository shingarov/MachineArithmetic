Class {
	#name : #BImply,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BImply class >> operator [
	^'==>'
]

{ #category : #selfification }
BImply class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x ==> y)]'
]

{ #category : #'reflect - embedding' }
BImply >> embedPrim: args [
	self shouldBeImplemented "need PImp"
]

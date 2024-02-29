Class {
	#name : #BLt,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BLt class >> operator [
	^'<'
]

{ #category : #selfification }
BLt class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x < y)]'
]

{ #category : #'reflect - embedding' }
BLt class >> smalltalkSelector [
	^#<
]

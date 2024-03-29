Class {
	#name : #BLe,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BLe class >> operator [
	^'<='
]

{ #category : #selfification }
BLe class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x <= y)]'
]

{ #category : #'reflect - embedding' }
BLe class >> smalltalkSelector [
	^#<=
]

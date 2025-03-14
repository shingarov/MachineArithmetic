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
BLe >> embedPrim: args [
"
embedPrim BLe    [e1, e2] = F.PAtom F.Le    e1 e2
"
	self assert: args size = 2.
	^PAtom
		brel: #<=
		x: args first
		y: args second
]

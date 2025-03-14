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
BLt >> embedPrim: args [
"
embedPrim BLt    [e1, e2] = F.PAtom F.Lt    e1 e2
"
	self assert: args size = 2.
	^PAtom
		brel: #<
		x: args first
		y: args second
]

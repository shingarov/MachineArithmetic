Class {
	#name : #BEq,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BEq class >> operator [
	^'=='
]

{ #category : #selfification }
BEq class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x === y)]'
]

{ #category : #'reflect - embedding' }
BEq >> embedPrim: args [
"
embedPrim BEq    [e1, e2] = F.PAtom F.Eq    e1 e2
"
	self assert: args size = 2.
	^PAtom
		brel: #===
		x: args first
		y: args second
]

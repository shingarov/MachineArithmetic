Class {
	#name : #BGe,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BGe class >> operator [
	^'>='
]

{ #category : #selfification }
BGe class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x >= y)]'
]

{ #category : #'reflect - embedding' }
BGe >> embedPrim: args [
"
embedPrim BGe    [e1, e2] = F.PAtom F.Ge    e1 e2
"
	self assert: args size = 2.
	^PAtom
		brel: #>=
		x: args first
		y: args second
]

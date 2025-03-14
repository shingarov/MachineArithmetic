Class {
	#name : #BNe,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BNe class >> operator [
	^'!='
]

{ #category : #selfification }
BNe class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x === y) not]'
]

{ #category : #'reflect - embedding' }
BNe >> embedPrim: args [
	self assert: args size = 2.
	^(PAtom
		brel: #===
		x: args first
		y: args second) not
]

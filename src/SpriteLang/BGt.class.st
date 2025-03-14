Class {
	#name : #BGt,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BGt class >> operator [
	^'>'
]

{ #category : #selfification }
BGt class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x > y)]'
]

{ #category : #'reflect - embedding' }
BGt >> embedPrim: args [
"
embedPrim BGt    [e1, e2] = F.PAtom F.Gt    e1 e2
"
	self assert: args size = 2.
	^PAtom
		brel: #>
		x: args first
		y: args second
]

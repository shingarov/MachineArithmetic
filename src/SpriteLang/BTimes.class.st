Class {
	#name : #BTimes,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BTimes class >> operator [
	^'*'
]

{ #category : #selfification }
BTimes class >> rTypeSrc [
	^'x:int => y:int => int[v|v===(x*y)]'
]

{ #category : #'reflect - embedding' }
BTimes >> embedPrim: args [
"
embedPrim BTimes [e1, e2] = F.EBin  F.Times e1 e2
"
	self assert: args size = 2.
	^EBin
		bop: #*
		left: args first
		right: args second
]

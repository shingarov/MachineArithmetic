Class {
	#name : #BMinus,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BMinus class >> operator [
	^'-'
]

{ #category : #selfification }
BMinus class >> rTypeSrc [
	^'x:int => y:int => int[v|v===(x-y)]'
]

{ #category : #'reflect - embedding' }
BMinus >> embedPrim: args [
"
embedPrim BMinus [e1, e2] = F.EBin  F.Minus e1 e2
"
	self assert: args size = 2.
	^EBin
		bop: #-
		left: args first
		right: args second
]

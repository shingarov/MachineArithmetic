Class {
	#name : #BPlus,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BPlus class >> operator [
	^'+'
]

{ #category : #selfification }
BPlus class >> rTypeSrc [
	^'x:int => y:int => int[v|v===(x+y)]'
]

{ #category : #'reflect - embedding' }
BPlus >> embedPrim: args [
"
embedPrim BPlus  [e1, e2] = F.EBin  F.Plus  e1 e2
"
	self assert: args size = 2.
	^EBin
		bop: #+
		left: args first
		right: args second
]

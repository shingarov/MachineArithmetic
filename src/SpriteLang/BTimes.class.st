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
BTimes class >> smalltalkSelector [
	^#*
]

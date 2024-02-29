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
BMinus class >> smalltalkSelector [
	^#-
]

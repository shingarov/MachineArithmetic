Class {
	#name : #BOr,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BOr class >> operator [
	^'||'
]

{ #category : #selfification }
BOr class >> rTypeSrc [
	^'x:bool => y:bool => bool[v|v <=> (x | y)]'
]

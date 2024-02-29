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
BGt class >> smalltalkSelector [
	^#>
]

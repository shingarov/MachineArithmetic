Extension { #name : #String }

{ #category : #'*SpriteLang' }
String class >> junkSymbol [
"
junkSymbol :: F.Symbol
junkSymbol = '_'
cf. Types.hs
"
	^'_'
]

{ #category : #'*SpriteLang' }
String >> nonRigid [
	^self beginsWith: 'fvºº'
]

{ #category : #'*SpriteLang' }
String >> unifyX: anotherString [ 
	^self
]

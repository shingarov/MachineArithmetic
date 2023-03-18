Extension { #name : #HPredAnd }

{ #category : #'*SpriteLang' }
HPredAnd >> pTrivial [
	ps isEmpty ifTrue: [ ^false ].
	^super pTrivial
]

{ #category : #'*SpriteLang' }
HPredAnd >> smash [
"
smash (H.PAnd ps) = concatMap smash ps
"
	^ps collectAndCat: #smash
]

{ #category : #'*SpriteLang' }
HPredAnd >> subs: p ar: ar [
	^HPredAnd of: (ps collect: [ :each | each subs: p ar: ar ])
]

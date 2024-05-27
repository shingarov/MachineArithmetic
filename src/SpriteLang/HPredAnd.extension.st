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
	^ps >>= #smash
]

{ #category : #'*SpriteLang' }
HPredAnd >> subs: p ar: ar [
	^HPredAnd of: (ps collect: [ :each | each subs: p ar: ar ])
]

{ #category : #'*SpriteLang' }
HPredAnd >> subsAR: aString ar: anARef [
	^HPredAnd of: (ps collect: [ :each | each subsAR: aString ar: anARef ])
]

{ #category : #'*SpriteLang' }
HPredAnd >> uniq2: α [
	^self class of: (ps collect: [:e|e uniq2: α])

]

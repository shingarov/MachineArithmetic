Extension { #name : #HReft }

{ #category : #'*SpriteLang' }
HReft >> pTrivial [
	^expr isTautoPred
]

{ #category : #'*SpriteLang' }
HReft >> predExprsGo [
	^expr conjuncts
]

{ #category : #'*SpriteLang' }
HReft >> subs: p ar: ar [
	^self
]

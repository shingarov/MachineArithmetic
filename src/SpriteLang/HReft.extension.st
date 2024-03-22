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

{ #category : #'*SpriteLang' }
HReft >> uniq2: α [
	^self class expr: (expr uniq2: α)

]

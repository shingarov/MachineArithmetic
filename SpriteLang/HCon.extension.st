Extension { #name : #HCon }

{ #category : #'*SpriteLang' }
HCon class >> papp: n [
n=1 ifFalse: [self shouldBeImplemented].
	^NNFParser new constant parse: 'constant papp1 (func(1 , [(Pred @(0)); @(0); bool]))'
]

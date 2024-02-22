Extension { #name : #String }

{ #category : #'*PreSmalltalks-Substitutions' }
String >> subst: su [
	^(su appSubst: self) subSymbol: self
]

{ #category : #'*PreSmalltalks-Substitutions' }
String >> substa: f [
	^f value: self
]

{ #category : #'*PreSmalltalks-Substitutions' }
String >> substf: f [
	^(f value: self) subSymbol: self
]

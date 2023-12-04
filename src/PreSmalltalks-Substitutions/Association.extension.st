Extension { #name : #Association }

{ #category : #'*PreSmalltalks-Substitutions' }
Association >> subst: su [
	^(self key subst: su) -> (self value subst: su)
]

{ #category : #'*PreSmalltalks-Substitutions' }
Association >> substa: su [
	^(self key substa: su) -> (self value substa: su)
]

{ #category : #'*PreSmalltalks-Substitutions' }
Association >> substf: su [
	^(self key substf: su) -> (self value substf: su)
]

{ #category : #'*PreSmalltalks-Substitutions' }
Association >> syms [
	^self key syms, self value syms
]

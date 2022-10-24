Extension { #name : #Dictionary }

{ #category : #'*PreSmalltalks-Substitutions' }
Dictionary >> subst: su [
	^self collect: [ :eachValue | eachValue subst: su ]
]

{ #category : #'*PreSmalltalks-Substitutions' }
Dictionary >> substa: su [
	^self collect: [ :eachValue | eachValue substa: su ]
]

{ #category : #'*PreSmalltalks-Substitutions' }
Dictionary >> substf: su [
	^self collect: [ :eachValue | eachValue substf: su ]
]

{ #category : #'*PreSmalltalks-Substitutions' }
Dictionary >> syms [
	^self values syms
]

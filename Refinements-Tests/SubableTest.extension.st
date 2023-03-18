Extension { #name : #SubableTest }

{ #category : #'*Refinements-Tests' }
SubableTest >> testStringSubstFound [
	| su |
	su := Subst newFromAssociations: { 'a'->(EVar of: 'b') }.
	self assert: ('a' subst: su) equals: 'b'
]

{ #category : #'*Refinements-Tests' }
SubableTest >> testStringSubstFoundNil [
	| su |
	su := Subst newFromAssociations: { 'a'->nil }.
	self assert: ('a' subst: su) equals: 'a'
]

{ #category : #'*Refinements-Tests' }
SubableTest >> testStringSubstNotFound [
	| su |
	su := Subst newFromAssociations: { 'a'->'b' }.
	
	self assert: ('x' subst: su) equals: 'x'
]

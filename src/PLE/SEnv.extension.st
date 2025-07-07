Extension { #name : #SEnv }

{ #category : #'*PLE' }
SEnv >> mkCoSub: eTs xTs: xTs [
"
mkCoSub :: SEnv Sort -> [Sort] -> [Sort] -> Vis.CoSub
Cf. Solver/PLE.hs
"
	| senv unite xys |
	senv := self mkSearchEnv.
	unite := [ :ts | (senv unifyTo1: ts) ifNil: [ self error: 'mkCoSub: cannot build CoSub for ', xys printString, ' cannot unify ', ts printString ] ].
	xys := (xTs zip: eTs with: [ :xT :eT | xT matchSorts: eT ]) join sortedNub.
	^CoSub newFromAssociations: (xys groupList collectAssociations: [ :x :ys | x -> (unite ∘ ys asArray) ])
]

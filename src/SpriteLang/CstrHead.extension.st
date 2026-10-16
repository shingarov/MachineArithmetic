Extension { #name : #CstrHead }

{ #category : #'*SpriteLang' }
CstrHead >> simplifyConstraintGo [
"
go (H.Head (H.Reft p) _)
  | F.isTautoPred p  = Nothing
"
	((pred isKindOf: HReft) and: [ pred expr isTautoPred ]) ifTrue: [ ^nil ].
	^super simplifyConstraintGo
]

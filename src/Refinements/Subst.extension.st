Extension { #name : #Subst }

{ #category : #'*Refinements' }
Subst >> appSubst: sym [
	"appSubst :: Subst -> Symbol -> Expr"
	^self at: sym ifAbsent: (EVar of: sym)
]

{ #category : #'*Refinements' }
Subst class >> mkSubstNameToName: oldToNewVarNameAssocs [ 
	"Make a Subst from the argument which is a sequence of Associations of the form, varName->varName."
	| su |
	su := oldToNewVarNameAssocs collectAssociations: [ :old :new | old -> (EVar of: new) ].
	^self mkSubst: su
]

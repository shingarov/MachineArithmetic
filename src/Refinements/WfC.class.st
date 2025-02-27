"
An environment Γ is a set of type bindings x:τ.
Γ ⊦ c means ""c is well-formed under Γ"".
To establish well-formedness we use these three rules:

 Γ ⊦ r : Bool
-------------- W-Ref
   Γ ⊦ r

If we know that r can be typed as Bool using vulgar rules,
then r is well-formed.

 Γ ⊦ c1   Γ ⊦ c2
----------------- W-And
   Γ ⊦ c1 ∧ c2

If conjuncts are well-formed then their AND is well-formed.

 Γ;x:b ⊦ c   Γ;x:b ⊦ r
----------------------- W-Imp
   Γ ⊦ ∀x:b. r ⇒ c

If the premiss c and the conclusion r are well-formed in
Γ extended by x:b, then the implication is well-formed in Γ.

NB: constraints containing κ-applications are NOT well-formed.

data WfC a  =  WfC  { wenv  :: !IBindEnv
                    , wrft  :: (Symbol, Sort, KVar)
                    , winfo :: !a
                    }
Cf. Types/Constraints.hs
"
Class {
	#name : #WfC,
	#superclass : #Object,
	#instVars : [
		'env',
		'rft'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
WfC class >> be: anIBindEnv sr: aSortedReft x: meta [
"Nonono. We are not calling this smartass constructor yet."
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
WfC class >> env: anIBindEnv rft: Symbol_Sort_KVar [
	^self basicNew
		env: anIBindEnv;
		rft: Symbol_Sort_KVar;
		yourself

]

{ #category : #accessing }
WfC >> env [
	^ env
]

{ #category : #accessing }
WfC >> env: anObject [
	env := anObject
]

{ #category : #printing }
WfC >> printOn: aStream [
	aStream nextPutAll: 'wf: ['.
	env indexes printOn: aStream delimiter: ','.
	aStream nextPutAll: '] {'.
	aStream nextPutAll: rft first.
	aStream nextPutAll: ' : '.
	rft second printOn: aStream.
	aStream nextPutAll: ' | [$'.
	aStream nextPutAll: rft third.
	aStream nextPutAll: ']}'.
]

{ #category : #accessing }
WfC >> rft [
	^ rft
]

{ #category : #accessing }
WfC >> rft: anObject [
	rft := anObject
]

{ #category : #'as yet unclassified' }
WfC >> updateWfCExpr: subst [ 
	"This is for GWfC only.  We aren't there yet."
	^self
]

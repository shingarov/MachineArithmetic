"
sEnv :: !SymEnv                      -- ^ Environment used to elaborate solutions
sMap :: !(M.HashMap KVar a)          -- ^ Actual solution (for cut kvar)
gMap :: !(M.HashMap KVar b)          -- ^ Solution for gradual variables
sHyp :: !(M.HashMap KVar Hyp)        -- ^ Defining cubes  (for non-cut kvar)
sScp :: !(M.HashMap KVar IBindEnv)   -- ^ Set of allowed binders for kvar
sEbd :: !(M.HashMap BindId EbindSol) -- ^ EbindSol for each existential binder
sxEnv :: !(SEnv (BindId, Sort))      --   TODO: merge with sEnv? used for sorts of ebinds to solve ebinds in lhsPred

(cf. Solutions.hs)
"
Class {
	#name : #Sol,
	#superclass : #Object,
	#instVars : [
		'sEnv',
		'sMap',
		'gMap',
		'sHyp',
		'sScp',
		'sEbd',
		'sxEnv'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #accessing }
Sol >> gMap [
	^ gMap
]

{ #category : #accessing }
Sol >> gMap: anObject [
	gMap := anObject
]

{ #category : #accessing }
Sol >> sEbd [
	^ sEbd
]

{ #category : #accessing }
Sol >> sEbd: anObject [
	sEbd := anObject
]

{ #category : #accessing }
Sol >> sEnv [
	^ sEnv
]

{ #category : #accessing }
Sol >> sEnv: anObject [
	sEnv := anObject
]

{ #category : #accessing }
Sol >> sHyp [
	^ sHyp
]

{ #category : #accessing }
Sol >> sHyp: anObject [
	sHyp := anObject
]

{ #category : #accessing }
Sol >> sMap [
	^ sMap
]

{ #category : #accessing }
Sol >> sMap: anObject [
	sMap := anObject
]

{ #category : #accessing }
Sol >> sScp [
	^ sScp
]

{ #category : #accessing }
Sol >> sScp: anObject [
	sScp := anObject
]

{ #category : #accessing }
Sol >> sxEnv [
	^ sxEnv
]

{ #category : #accessing }
Sol >> sxEnv: anObject [
	sxEnv := anObject
]

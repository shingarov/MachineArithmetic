"
--------------------------------------------------------------------------------
-- | 'SymEnv' is used to resolve the 'Sort' and 'Sem' of each 'Symbol'
--------------------------------------------------------------------------------
data SymEnv = SymEnv {
seSort    :: !(SEnv Sort)              -- ^ Sorts of *all* defined symbols
seTheory  :: !(SEnv TheorySymbol)      -- ^ Information about theory-specific Symbols
seData    :: !(SEnv DataDecl)          -- ^ User-defined data-declarations
seLits    :: !(SEnv Sort)              -- ^ Distinct Constant symbols
seAppls   :: !(M.HashMap FuncSort Int) -- ^ Types at which `apply` was used;
                                          --   see [NOTE:apply-monomorphization]
}
"
Class {
	#name : #SymEnv,
	#superclass : #Object,
	#instVars : [
		'seSort',
		'seTheory',
		'seData',
		'seLits',
		'seAppls'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SymEnv >> , y [ 
	^SymEnv new "BOGUS, SymEnvs aren't there at all yet"
]

{ #category : #'as yet unclassified' }
SymEnv >> makeContextWithSEnv [
	"This is where the SMT context is created in Liquid.
	All we need in Smalltalk is the env"
	^self
]

"
--------------------------------------------------------------------------------
-- | 'Sem' describes the SMT semantics for a given symbol
--------------------------------------------------------------------------------
    
data Sem
  = Uninterp      -- ^ for UDF: `len`, `height`, `append`
  | Ctor          -- ^ for ADT constructor and tests: `cons`, `nil`
  | Test          -- ^ for ADT tests : `is$cons`
  | Field         -- ^ for ADT field: `hd`, `tl`
  | Theory        -- ^ for theory ops: mem, cup, select
  deriving (Eq, Ord, Show, Data, Typeable, Generic)
"
Class {
	#name : #SMTSem,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #yoneda }
SMTSem class >> apply: functionName to: args ofZ3sorts: argSorts returning: aZ3Sort [
	^self subclassResponsibility
]

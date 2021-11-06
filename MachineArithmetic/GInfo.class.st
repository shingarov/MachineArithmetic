"
cm       :: !(M.HashMap SubcId (c a))  -- ^ cst id |-> Horn Constraint
  , ws       :: !(M.HashMap KVar (WfC a))  -- ^ Kvar  |-> WfC defining its scope/args
  , bs       :: !BindEnv                   -- ^ Bind  |-> (Symbol, SortedReft)
  , ebinds   :: ![BindId]                  -- ^ Subset of existential binders
  , gLits    :: !(SEnv Sort)               -- ^ Global Constant symbols
  , dLits    :: !(SEnv Sort)               -- ^ Distinct Constant symbols
  , kuts     :: !Kuts                      -- ^ Set of KVars *not* to eliminate
  , quals    :: ![Qualifier]               -- ^ Abstract domain
  , bindInfo :: !(M.HashMap BindId a)      -- ^ Metadata about binders
  , ddecls   :: ![DataDecl]                -- ^ User-defined data declarations
  , hoInfo   :: !HOInfo                    -- ^ Higher Order info
  , asserts  :: ![Triggered Expr]          -- ^ TODO: what is this?
  , ae       :: AxiomEnv                   -- ^ Information about reflected function defs
"
Class {
	#name : #GInfo,
	#superclass : #Object,
	#instVars : [
		'cm',
		'ws',
		'bs',
		'ebinds',
		'gLits',
		'dLits',
		'kuts',
		'quals',
		'bindInfo',
		'ddecls',
		'hoInfo',
		'asserts',
		'ae'
	],
	#category : #'MachineArithmetic-Refinement'
}

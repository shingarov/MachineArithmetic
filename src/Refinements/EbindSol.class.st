"
--------------------------------------------------------------------------------
-- | An `EbindSol` contains the relevant information for an existential-binder;
--   (See tests/pos/ebind-*.fq for examples.) This is either 
--   1. the constraint whose HEAD is a singleton that defines the binder, OR 
--   2. the solved out TERM that we should use in place of the ebind at USES.
--------------------------------------------------------------------------------
data EbindSol
  = EbDef [SimpC ()] Symbol -- ^ The constraint whose HEAD ""defines"" the Ebind
                             -- and the @Symbol@ for that EBind
  | EbSol Expr             -- ^ The solved out term that should be used at USES.
  | EbIncr                 -- ^ EBinds not to be solved for (because they're currently being solved for)
   deriving (Show, Generic, NFData)

Cf. Types/Solutions.hs
"
Class {
	#name : #EbindSol,
	#superclass : #Object,
	#category : #'Refinements-Solutions'
}

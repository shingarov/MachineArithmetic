"
---------------------------------------------------------------------------------------------- 
-- | @InstEnv@ has the global information needed to do PLE
---------------------------------------------------------------------------------------------- 

data InstEnv a = InstEnv 
  { ieCfg   :: !Config
  , ieSMT   :: !SMT.Context
  , ieBEnv  :: !BindEnv
  , ieAenv  :: !AxiomEnv 
  , ieCstrs :: !(CMap (SimpC a))
  , ieKnowl :: !Knowledge
  , ieEvEnv :: !EvalEnv
  } 

"
Class {
	#name : #InstEnv,
	#superclass : #Object,
	#category : #PLE
}

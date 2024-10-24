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
	#instVars : [
		'ieCfg',
		'ieSMT',
		'ieBEnv',
		'ieAenv',
		'ieCstrs',
		'ieKnowl',
		'ieEvEnv'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
InstEnv class >> ieCfg: ieCfg ieSMT: ieSMT ieBEnv: ieBEnv ieAenv: ieAenv ieCstrs: ieCstrs ieKnowl: ieKnowl ieEvEnv: ieEvEnv [
	^self basicNew
		ieCfg: ieCfg;
		ieSMT: ieSMT;
		ieBEnv: ieBEnv;
		ieAenv: ieAenv;
		ieCstrs: ieCstrs;
		ieKnowl: ieKnowl;
		ieEvEnv: ieEvEnv;
		yourself
]

{ #category : #accessing }
InstEnv >> ieAenv [
	^ ieAenv
]

{ #category : #accessing }
InstEnv >> ieAenv: anObject [
	ieAenv := anObject
]

{ #category : #accessing }
InstEnv >> ieBEnv [
	^ ieBEnv
]

{ #category : #accessing }
InstEnv >> ieBEnv: anObject [
	ieBEnv := anObject
]

{ #category : #accessing }
InstEnv >> ieCfg [
	^ ieCfg
]

{ #category : #accessing }
InstEnv >> ieCfg: anObject [
	ieCfg := anObject
]

{ #category : #accessing }
InstEnv >> ieCstrs [
	^ ieCstrs
]

{ #category : #accessing }
InstEnv >> ieCstrs: anObject [
	ieCstrs := anObject
]

{ #category : #accessing }
InstEnv >> ieEvEnv [
	^ ieEvEnv
]

{ #category : #accessing }
InstEnv >> ieEvEnv: anObject [
	ieEvEnv := anObject
]

{ #category : #accessing }
InstEnv >> ieKnowl [
	^ ieKnowl
]

{ #category : #accessing }
InstEnv >> ieKnowl: anObject [
	ieKnowl := anObject
]

{ #category : #accessing }
InstEnv >> ieSMT [
	^ ieSMT
]

{ #category : #accessing }
InstEnv >> ieSMT: anObject [
	ieSMT := anObject
]

{ #category : #'as yet unclassified' }
InstEnv >> initCtx: es [
"
initCtx :: InstEnv a -> [(Expr,Expr)] -> ICtx
" 
	^ICtx basicNew
		icAssms: Set new;
		icCands: Set new;
		icEquals: es asSet;
		icSolved: Set new;
		icSimpl: ConstMap new;
		icSubcId: nil;
		icFuel: 'evFuel (ieEvEnv env)';
		yourself
]

{ #category : #'as yet unclassified' }
InstEnv >> ple1: ctx mbBindId: i res: res [
"
Perform the PLE at a single 'node' in the Trie.

ple1 :: InstEnv a -> ICtx -> Maybe BindId -> InstRes -> IO (ICtx, InstRes)
           self      ctx          i            res
"
	| ictx′ |
	ictx′ := ctx evalCandsLoop: ieSMT knowledge: ieKnowl env: ieEvEnv.
	^res updCtxRes: i ctx: ictx′
]

{ #category : #'as yet unclassified' }
InstEnv >> withAssms: ctx delta: Δ maybeSubcId: cidMb act: act [
"
Add to ctx candidate expressions to unfold from the bindings in Δ and the rhs of cidMb.

Adds to ctx assumptions from @env@ and @delta@ plus rewrites that  
  -- candidates can use.
  --                  
  -- Sets the current constraint id in @ctx@ to @cidMb@.
  --                  
  -- Pushes assumptions from the modified context to the SMT solver, runs @act@,
  -- and then pops the assumptions.

withAssms :: InstEnv a -> ICtx -> Diff -> Maybe SubcId -> (ICtx -> IO b) -> IO b
               self       ctx      Δ         cidMb            act
"
	| ctx′ assms |
	ctx′ := ctx updCtx: self diff: Δ cidMb: cidMb.
	assms := ctx′ icAssms.
	^ieSMT bracket: [
		assms do: [ :each | ieSMT smtAssert: each ].	"forM_ assms (SMT.smtAssert ieSMT)"
		act value: ctx′
	]
]

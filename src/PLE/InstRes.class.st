"
-- | @InstRes@ is the final result of PLE; a map from @BindId@ to the equations ""known"" at that BindId
---------------------------------------------------------------------------------------------- 

type InstRes = M.HashMap BindId Expr
"
Class {
	#name : #InstRes,
	#superclass : #Dictionary,
	#category : #PLE
}

{ #category : #'as yet unclassified' }
InstRes >> resSInfo: fi symEnv: env [
"
-- | Step 3: @resSInfo@ uses incremental PLE result @InstRes@ to produce the strengthened SInfo 
---------------------------------------------------------------------------------------------- 

resSInfo :: Config -> SymEnv -> SInfo a -> InstRes -> SInfo a
             cfg       env        fi         res
"
	| is_ps res′ is ps ps′ ps′′ |
	is_ps := self associations.
	is := is_ps collect: #key.
	ps := is_ps collect: #value.
	ps′ := ps."defuncAny cfg env ps"
	self halt.
	
	ps′′ := is zip: ps′ with: [ :i :p | p "elaborate into what form SInfo wants?" ].

	res′ := self class newFromAssociations: (is zip: ps′′) .
	^res′ strengthenBinds: fi
]

{ #category : #'as yet unclassified' }
InstRes >> savePLEEqualities: fi [
"
savePLEEqualities :: Config -> SInfo a -> InstRes -> IO ()
                      cfg        fi        res
"
"
BOGUS, shoud do something
"
]

{ #category : #'as yet unclassified' }
InstRes >> strengthenBinds: si [
"
strengthenBinds :: SInfo a -> M.HashMap BindId Expr -> SInfo a
                    si                m
cf. Constraints.hs
"
	| f bs′ |
	f := [ :i :x_sr |
		| x sr | x := x_sr key. sr := x_sr value.
		self at: i
			ifPresent: [ :e | x -> (sr strengthenSortedReft: e) ]
			ifAbsent: [ x_sr ] ].
	bs′ := si bs mapBindEnv: f.
	^si copy
		bs: bs′;
		yourself
]

{ #category : #'as yet unclassified' }
InstRes >> updCtxRes: iMb ctx: ctx [
"
updCtxRes :: InstRes -> Maybe BindId -> ICtx -> (ICtx, InstRes)
            res=self         iMb        ctx
"
	| res′ |
	res′ := self updRes: iMb expr: ctx icEquals equalitiesPred.
	^ctx -> res′ 
]

{ #category : #'as yet unclassified' }
InstRes >> updRes: i expr: e [
"
updRes :: InstRes -> Maybe BindId -> Expr -> InstRes
                          i           e
"
	i isNil ifTrue: [ ^self ].
	^self copy
		at: i put: e;
		yourself
]

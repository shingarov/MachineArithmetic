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
	| res′ is ps ps′ ps′′ |
	is := self associations collect: #key.
	ps := self associations collect: #value.
	ps′ := ps.
	ps′′ := {
		(('adder__inst_1' functionFrom: { Int sort . Int sort } to: Int sort)
			value: 'x' toInt value: 'yºº1' toInt) === 11 } .

	res′ := self class newFromAssociations: (is zip: ps′′) .
	^res′ strengthenBinds: fi
]

{ #category : #'as yet unclassified' }
InstRes >> savePLEEqualities: fi [
"
savePLEEqualities :: Config -> SInfo a -> InstRes -> IO ()
                      cfg        fi        res
"
self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
InstRes >> strengthenBinds: si [
"
strengthenBinds :: SInfo a -> M.HashMap BindId Expr -> SInfo a
                    si                m
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

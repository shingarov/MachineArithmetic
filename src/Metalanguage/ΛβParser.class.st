Class {
	#name : #'ΛβParser',
	#superclass : #'ΛκParser',
	#instVars : [
		'constraint',
		'constraintEnv',
		'tyBindNoLoc'
	],
	#category : #'Metalanguage-Parsing'
}

{ #category : #grammar }
ΛβParser >> constraint [
"
constraintP :: Parser BareType
"
	^ constraintEnv
	, rtype
	, '≺:' asParser trim
	, rtype
	==> [ :x |
			| xts t1 t2 |
			xts := x first.
			t1 := x second.
			t2 := x fourth.
			"Unlike LH-proper, we do not go through the RTyperep dance.
			 The mechanics here are simple enough because constraintP is
			 only referenced from bareTypeBracesP."
			RRTyConstraintRep env: xts tl: t1 tr: t2 ]
]

{ #category : #grammar }
ΛβParser >> constraintEnv [
"
constraintEnvP :: Parser [(LocSymbol, BareType)]
"
	^ (tyBindNoLoc commaSeparated, '⊢' asParser ==> #first) optional
	==> [ :x | x ifNil: [ #() ] ]
	
]

{ #category : #grammar }
ΛβParser >> rtype [
	^ constraint braces optional, super rtype
	==> [ :c_rt |  | c rt |
		c := c_rt first.
		rt := c_rt second.
		c
			ifNil: [ rt ]
			ifNotNil: [ c rrTy: rt ]
	]
]

{ #category : #grammar }
ΛβParser >> tyBindNoLoc [
"
tyBindNoLocP :: Parser (LocSymbol, BareType)
tyBindNoLocP = second val <$> tyBindP

-- | Parses a type signature as it occurs in 'assume' and 'assert' directives.
tyBindP :: Parser (LocSymbol, Located BareType)
tyBindP =
  (,) <$> locBinderP <* reservedOp '::' <*> located genBareTypeP
"
	^ self identifier
	, '::' asParser
	, rtype
	==> [ :x | x first -> x last ]
]

"
-- | Case-Alternatives -----------------------------------------------------------

data Alt a = Alt 
  { altDaCon  :: !DaCon                     -- ^ Data constructor
  , altBinds  :: ![Bind a]                  -- ^ Binders x1...xn
  , altExpr   :: !(Expr a)                  -- ^ Body-expr
  , altLabel  :: a                          -- ^ Label
  }
  deriving (Show, Functor)
"
Class {
	#name : #Alt,
	#superclass : #Object,
	#instVars : [
		'daCon',
		'binds',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
Alt class >> daCon: daCon binds: binds expr: expr [
	^self basicNew
		daCon: daCon;
		binds: binds;
		expr: expr;
		yourself
]

{ #category : #accessing }
Alt >> binds [
	^ binds
]

{ #category : #accessing }
Alt >> binds: anObject [
	binds := anObject
]

{ #category : #accessing }
Alt >> daCon [
	^ daCon
]

{ #category : #accessing }
Alt >> daCon: anObject [
	daCon := anObject
]

{ #category : #'as yet unclassified' }
Alt >> elabAlt: Γ ident: y rtype: t [
	| unfolded e′ |
	unfolded := Γ unfoldEnv′: y daCon: daCon binds: binds.
	unfolded isNil ifTrue: [ self error: 'bad pattern match' ].
	e′ := expr elabC: unfolded rtype: t.
	^Alt
		daCon: daCon
		binds: binds
		expr: e′
]

{ #category : #'as yet unclassified' }
Alt >> embedAlt: x [
"
embedAlt :: Ident -> SrcAlt -> F.Expr
embedAlt x a@(Alt d  ys  e  _) = F.subst su (embed e) where …
                  ↑  ↑   ↑
              daCon  |   expr
                   binds
"
	| sub su |
	sub := [ :y :i | y id -> ((daCon selDataCon: i) mkEApp: x) ].
	su := Subst mkSubst: (binds collectWithIndex: [ :y :i | sub value: y value: i-1 ]).
	
	^expr embed subst: su
]

{ #category : #accessing }
Alt >> expr [
	^ expr
]

{ #category : #accessing }
Alt >> expr: anObject [
	expr := anObject
]

{ #category : #GT }
Alt >> gtBind [
	^''

]

{ #category : #GT }
Alt >> gtChildren [
	^{ expr }
]

{ #category : #GT }
Alt >> gtExpr [
	^self

]

{ #category : #'as yet unclassified' }
Alt >> isAlt: x [
"
isAlt :: SrcAlt -> Ident -> F.Expr
          self       x
"
	^daCon isDataCon mkEApp: x
]

{ #category : #testing }
Alt >> isLet [
	^false
]

{ #category : #printing }
Alt >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #'α-renaming' }
Alt >> uniq2: α [
	^self class
		daCon: daCon
		binds: (binds collect: [ :each | each uniq2: α])
		expr: (expr uniq2: α)
]

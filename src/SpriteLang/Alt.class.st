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

{ #category : #'as yet unclassified' }
Alt class >> embed: x alts: as [
"
embedAlts :: Ident -> [SrcAlt] -> F.Expr
               x         as
"
	| a rest |
	self assert: as size > 0.
	 
	"go [a]     = embedAlt x a"
	as size = 1 ifTrue: [ ^as anyOne embedAlt: x ].

	"go (a:as)  = F.EIte (isAlt a x) (embedAlt x a) (go as)"
	a := as first.  rest := as allButFirst.
	^EIte
		if: (a isAlt: x)
		then: (a embedAlt: x)
		else: (self embed: x alts: rest)
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
embedAlt :: Ident ->     SrcAlt       -> F.Expr
              x      a@(Alt d ys e _)
"
	| zipWith sub su |
	sub := [ :y :i |
		| selDataCon |
		selDataCon := daCon intSymbol: i.
		y id -> (selDataCon expr eApps: {x expr}) ].
	zipWith := binds"ys" with0basedIndexCollect: sub.
	su := Subst mkSubst: zipWith.
	^(expr embed) subst: su
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
isAlt a x = mkEApp (isDataCon (altDaCon a)) x
"
	| isDataCon |
	isDataCon := daCon testSymbol encodeUnsafe.
	^isDataCon expr eApps: { x expr }
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

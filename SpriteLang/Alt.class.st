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
	| unfolded e_ |
	"binds isEmpty ifFalse: [ self shouldBeImplemented ]."  "let al = mconcat (label <$> zs)"
	unfolded := Γ unfoldEnv_: y daCon: daCon binds: binds.
	unfolded isNil ifTrue: [ self error: 'bad pattern match' ].
	e_ := expr elabC: unfolded rtype: t.
	^Alt
		daCon: daCon
		binds: binds
		expr: e_
]

{ #category : #accessing }
Alt >> expr [
	^ expr
]

{ #category : #accessing }
Alt >> expr: anObject [
	expr := anObject
]

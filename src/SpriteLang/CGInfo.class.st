"
data CGInfo = CGInfo
  { cgiKVars  :: [SrcHVar]
  , cgiConsts :: [(F.Symbol, F.Sort)]
  , cgiDefs   :: [F.Equation]
  }
"
Class {
	#name : #CGInfo,
	#superclass : #Object,
	#instVars : [
		'cgiKVars',
		'cgiConsts',
		'cgiDefs'
	],
	#category : #'SpriteLang-CgMonad'
}

{ #category : #accessing }
CGInfo class >> current [
	^CGState current cgInfo
]

{ #category : #API }
CGInfo >> addReflectVar: f rtype: t xts: xts outputSort: ot expr: e [
	"Destructively modify the Constraint Generation State
	 by adding a new equation."
	| fDef |
	fDef := Equation
		mkEquation: f
		args: xts
		expr: e
		sort: ot.
	self cgiDefs add: fDef.
	self cgiConsts add: (HCon symbol: f sort: t rtypeSort)
]

{ #category : #API }
CGInfo >> addSrcKVar: k [
	self cgiKVars add: k
]

{ #category : #accessing }
CGInfo >> cgiConsts [
	cgiConsts isNil ifTrue: [ cgiConsts := OrderedCollection new ].
	^ cgiConsts
]

{ #category : #accessing }
CGInfo >> cgiDefs [
	cgiDefs isNil ifTrue: [ cgiDefs := OrderedCollection new ].
	^ cgiDefs
]

{ #category : #accessing }
CGInfo >> cgiKVars [
	cgiKVars isNil ifTrue: [ cgiKVars := OrderedCollection new ].
	^ cgiKVars
]

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

Class {
	#name : #QualParam,
	#superclass : #HThing,
	#instVars : [
		'symbol',
		'pattern',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
QualParam class >> symbol: sym sort: srt [
	^self symbol: sym sort: srt pattern: nil
]

{ #category : #'instance creation' }
QualParam class >> symbol: sym sort: srt pattern: p [
	^self basicNew 
		symbol: sym;
		sort: srt;
		pattern: p;
		yourself
]

{ #category : #comparing }
QualParam >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^symbol = rhs symbol
	and: [ pattern = rhs pattern
	and: [ sort = rhs sort ] ]
]

{ #category : #'as yet unclassified' }
QualParam >> apply: su qpSubst: qsu [
	"applyQP :: So.TVSubst -> QPSubst -> F.QualParam -> F.QualParam"
	^QualParam
		symbol: symbol
		sort: (sort apply: su)
		pattern: (pattern ifNil: [ nil ] ifNotNil: [ self shouldBeImplemented ])
]

{ #category : #'as yet unclassified' }
QualParam >> candidates: env tyss: tyss [
"candidates :: So.Env -> [(F.Sort, [F.Symbol])] -> F.QualParam
           -> [(So.TVSubst, QPSubst, F.Symbol)]"
	| xt mono result |
	xt := sort.
	mono := xt isMono.
	result := tyss associations collectAndCat: [ :t_ys |
		| t ys | t := t_ys key. ys := t_ys value.
		(xt unify: t env: env fast: mono) maybeToList
			collectAndCat: [ :su | ys asArray collectAndCat: [ :y |
					(self matchSym: y) maybeToList collectAndCat: [ :qsu |
						{ su -> qsu -> y } ] ] ] ].
	^result collect: #toTriple
]

{ #category : #'as yet unclassified' }
QualParam >> eraseSymbol [
	^self copy
		symbol: HBind dummyName;
		yourself
]

{ #category : #comparing }
QualParam >> hash [
	^symbol hash
]

{ #category : #'as yet unclassified' }
QualParam >> matchSym: y1 [
"
matchSym :: F.QualParam -> F.Symbol -> Maybe QPSubst
"
	pattern isNil ifFalse: [ self shouldBeImplemented ].
	^NoSub new
]

{ #category : #accessing }
QualParam >> pattern [
	^ pattern
]

{ #category : #accessing }
QualParam >> pattern: anObject [
	pattern := anObject
]

{ #category : #printing }
QualParam >> printOn: aStream [
	pattern isNil ifFalse: [ self shouldBeImplemented ].
	aStream nextPutAll: symbol.
	aStream nextPut: (Character value: 16r2208).
	sort printOn: aStream

]

{ #category : #accessing }
QualParam >> sort [
	^ sort
]

{ #category : #accessing }
QualParam >> sort: anObject [
	sort := anObject
]

{ #category : #accessing }
QualParam >> symbol [
	^ symbol
]

{ #category : #accessing }
QualParam >> symbol: anObject [
	symbol := anObject
]

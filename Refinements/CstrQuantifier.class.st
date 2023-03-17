"
If we think of a constraint as a tree, I am an internal node
which quantifies a variable x of basic type b:
 ∀x:b. hyp ⇒ concl

Here x, b and hyp are contained in the bind :: HBind,
and concl is the CstrQuantifier's p.
"
Class {
	#name : #CstrQuantifier,
	#superclass : #HCstr,
	#instVars : [
		'bind',
		'p'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
CstrQuantifier class >> bind: b p: p [
"((((b x beginsWith: 'VV1')
and: [ p isKindOf: CstrHead ])
and: [ p pred isKindOf: DelayedSubst ])
and: [ p pred expression text = '(len value: v) === ((len value: xs) + (len value: ys))' ])
ifTrue: [ self halt ]."

	(p isKindOf: HCstr) ifFalse: [ self error ].
	^self basicNew 
		bind: b;
		p: p;
		yourself 
]

{ #category : #'instance creation' }
CstrQuantifier class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
CstrQuantifier class >> varName: varName τ: τ r: r smalltalkBlock: p [
	| bind x ref pred |
	x := τ mkConst: varName asString.
	ref := r isNil ifTrue: [ Bool true ] ifFalse: [ r value: x ].
	(ref isKindOf: RefVarApp) ifFalse: [ ref := ResolvedPredicate z3bool: ref ].
	pred := p value: x.
	bind := HBind x: varName asString τ: τ p: ref.
	^self bind: bind p: pred toHCstr
]

{ #category : #accessing }
CstrQuantifier >> bind [
	^ bind
]

{ #category : #accessing }
CstrQuantifier >> bind: anObject [
	bind := anObject
]

{ #category : #logic }
CstrQuantifier >> boundKVars [
	^ self bind p pKVars, self p boundKVars
]

{ #category : #GT }
CstrQuantifier >> children [ 
	^Array with: p
]

{ #category : #accessing }
CstrQuantifier >> flatConstraint [ 
	^self class 
		bind: (HBind x: bind x τ: bind τ p: bind p flatConstraint)
		p: p flatConstraint
]

{ #category : #printing }
CstrQuantifier >> mathSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
CstrQuantifier >> p [
	^ p
]

{ #category : #accessing }
CstrQuantifier >> p: anObject [
	p := anObject
]

{ #category : #printing }
CstrQuantifier >> ppOn: aStream indent: n [
	n timesRepeat: [ 	aStream nextPutAll: ' ' ].
	aStream nextPutAll: '('.
	aStream nextPut: self mathSymbol.
	bind printOn: aStream.
	aStream cr.
	p ppOn: aStream indent: n+1.
	aStream nextPutAll: ')'.
]

{ #category : #printing }
CstrQuantifier >> printMeatOn: aStream [
	aStream nextPut: self mathSymbol.
	self bind printOn: aStream.
	aStream nextPutAll: ' : ...'
]

{ #category : #'term rewriting' }
CstrQuantifier >> pruneTauts [ 
	^self class 
		bind: bind p: p pruneTauts
]

{ #category : #logic }
CstrQuantifier >> uniq1: α [
	| x b_ c2_ |
	b_ := bind uBind: α.
	x := bind x.
	c2_ := p uniq1: α.
	α popName: x.
	^self class bind: b_ p: c2_
]

{ #category : #'as yet unclassified' }
CstrQuantifier >> uniq: anAlphaRenamer [
	(anAlphaRenamer hasSeen: bind x)
		ifTrue: [  ]
		ifFalse: [  ]
]

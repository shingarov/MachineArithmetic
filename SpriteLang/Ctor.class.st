Class {
	#name : #Ctor,
	#superclass : #Object,
	#instVars : [
		'dc',
		'xts',
		'r'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
Ctor class >> bind: bind funArgs: symbolToRType_assocs reft: maybeReft [
	^self basicNew
		dc: bind;
		xts: symbolToRType_assocs;
		r: maybeReft;
		yourself
]

{ #category : #accessing }
Ctor >> dc [
	^ dc
]

{ #category : #accessing }
Ctor >> dc: anObject [
	dc := anObject
]

{ #category : #'as yet unclassified' }
Ctor >> mkCtor: tc tvs: tvs rvs: rvs [
"
Ident -> [Ident] -> [RVar] -> Ctor -> (SrcBind, RType)
cf. Parse.hs
"
	| dcReft dcRes dcType |
	dcReft := r ifNil: [ΛReft new].
	dcRes := TCon c: tc ts: (tvs collect: #rVar) ars: (rvs collect: #rVarARef__parse) r: dcReft.
	"dcType := xts reversed inject: dcRes into: [ :s :x_t |
		| x t |
		x := x_t key.  t := x_t value.
		TFun x: x s: t t: s ]."
	^ dc -> (dcRes closeType: rvs xts: xts)
]

{ #category : #accessing }
Ctor >> r [
	^ r
]

{ #category : #accessing }
Ctor >> r: anObject [
	r := anObject
]

{ #category : #accessing }
Ctor >> xts [
	^ xts
]

{ #category : #accessing }
Ctor >> xts: anObject [
	xts := anObject
]

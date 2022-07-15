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
Ctor >> mkCtor: tc args: args [
"Ident -> [Ident] -> Ctor -> (SrcBind, RType)"
	| dcReft dcRes dcType |
	dcReft := r ifNil: [ΛReft new].
	dcRes := TCon c: tc ts: (args collect: [ :eachArg | RType rVar: eachArg ]) r: dcReft.
	dcType := xts reversed inject: dcRes into: [ :s :x_t |
		| x t |
		x := x_t key.  t := x_t value.
		TFun x: x s: t t: s ].
	^ dc -> dcType generalize
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

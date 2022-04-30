Class {
	#name : #TAll,
	#superclass : #RType,
	#instVars : [
		'var',
		'type'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
TAll class >> var: v type: t [
	^self basicNew var: v; type: t; yourself
]

{ #category : #'as yet unclassified' }
TAll >> freeTVarsGo [
	^self shouldBeImplemented "delete a (go t)"
]

{ #category : #'as yet unclassified' }
TAll >> fresh: Γ [
	^TAll var: var type: (type fresh: Γ)
]

{ #category : #GT }
TAll >> gtChildren [
	^{type}
]

{ #category : #'as yet unclassified' }
TAll >> instantiateGo: ts [
"cf. Elaborate.hs"
	| v vt |
	v := ElabState current freshTVar.
	vt := TBase b: (TVar symbol: v) r: ΛReft new.
	^(type tsubst: vt tVar: var) instantiateGo: {vt}, ts
]

{ #category : #printing }
TAll >> printOn: aStream [
	aStream
			nextPutAll: 'TAll ';
			nextPutAll: var;
			nextPutAll: ' ('.
	type printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'as yet unclassified' }
TAll >> splitTAll [
	"plitTAll :: RType -> ([TVar], RType)"
	| as_t as t |
	as_t := type splitTAll.
	as := as_t first.  t := as_t last.
	^{ {var}, as . t }
]

{ #category : #polymorphism }
TAll >> strengthenTop: _r [
	^self
]

{ #category : #'as yet unclassified' }
TAll >> subsTy: su [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
TAll >> tsubst: t tVar: a [ 
	| b s |
	b := var.
	s := type.
	a = b ifTrue: [ ^TAll var: b type: s "basically myself" ].
	^TAll var: b type: (s tsubst: t tVar: a)
]

{ #category : #accessing }
TAll >> type [
	^ type
]

{ #category : #accessing }
TAll >> type: anObject [
	type := anObject
]

{ #category : #accessing }
TAll >> var [
	^ var
]

{ #category : #accessing }
TAll >> var: anObject [
	var := anObject
]

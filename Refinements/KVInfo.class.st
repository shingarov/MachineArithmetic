Class {
	#name : #KVInfo,
	#superclass : #Object,
	#instVars : [
		'kvVar',
		'kvParams',
		'kvWfC'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
KVInfo class >> be: initialBindEnv k: anHVar [
	"Create a new instance of KVInfo based on k,
	insert args into initialBindEnv making a new BindEnv,
	and return newBindEnv->KVInfoInstance.
	
	kvInfo :: F.BindEnv -> H.Var a -> (F.BindEnv, KVInfo a)
	Cf. Info.hs.
	"
	| xts x t xts1 be1_ids be1 ids wenv wrft wfc |
	xts := anHVar formalArguments.
	x := xts first key.
	t := xts first value.
	xts1 := xts allButFirst.
	be1_ids := xts1
		colject: initialBindEnv
		into: [ :beSoFar :thisBinding | (beSoFar insertVar: thisBinding key sort: thisBinding value) reverse ].
	be1 := be1_ids key.
	ids := be1_ids value.
	wenv := IBindEnv from: ids.
	wrft := { x. t. anHVar name }.
	wfc := WfC new 
		env: wenv;
		rft: wrft;
		yourself.
	^be1 -> (self basicNew
		kvVar: anHVar name;
		kvParams: (xts collect: [ :xt | xt key]);
		kvWfC: wfc;
		yourself)
]

{ #category : #accessing }
KVInfo >> kvParams [
	^ kvParams
]

{ #category : #accessing }
KVInfo >> kvParams: anObject [
	kvParams := anObject
]

{ #category : #accessing }
KVInfo >> kvVar [
	^ kvVar
]

{ #category : #accessing }
KVInfo >> kvVar: anObject [
	kvVar := anObject
]

{ #category : #accessing }
KVInfo >> kvWfC [
	^ kvWfC
]

{ #category : #accessing }
KVInfo >> kvWfC: anObject [
	kvWfC := anObject
]

{ #category : #printing }
KVInfo >> printOn: aStream [
	aStream nextPut: $$.
	aStream nextPutAll: kvVar.
	aStream nextPut: $(.
	kvParams printOn: aStream delimiter: ', '.
	aStream nextPutAll: ') '.
	kvWfC printOn: aStream
]

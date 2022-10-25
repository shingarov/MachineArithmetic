Class {
	#name : #PreConstant,
	#superclass : #Object,
	#instVars : [
		'name',
		'sort'
	],
	#classVars : [
		'hotel'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
PreConstant class >> name: n sort: s [
	^self basicNew 
		name: n;
		sort: s;
		yourself
]

{ #category : #accessing }
PreConstant >> name [
	^ name
]

{ #category : #accessing }
PreConstant >> name: anObject [
	name := anObject
]

{ #category : #printing }
PreConstant >> printOn: aStream [
	aStream nextPutAll: 'PreConst '.
	aStream nextPutAll: name.
	aStream nextPutAll: ' ∈ '.
	sort printOn: aStream

]

{ #category : #accessing }
PreConstant >> sort [
	^ sort
]

{ #category : #accessing }
PreConstant >> sort: anObject [
	sort := anObject
]

{ #category : #'as yet unclassified' }
PreConstant >> toZ3Node [
	"Assume everything is already elaborated (if not, things will crash in spectacular ways).
	 Answer the already-calculated Z3 answer.
	"
	| z3node |
	z3node := Context currentElabEnv senv sort at: name.
	^z3node mkConst: name
]

{ #category : #'as yet unclassified' }
PreConstant >> value: arg [
	| appSort f_x f x |
	appSort := EApp expr: sort instantiate imm: arg sort.
	f_x := appSort elab: Context currentElabEnv .
	f := f_x first withName: name.
	Context currentElabEnv senv sort note: sort elaboratedTo: f.
	x := arg toZ3Node.
	^f value: x
]

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

{ #category : #testing }
PreConstant >> isConstantNamed: aString [ 
	^name = aString
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
PreConstant >> toZ3Sort: s [
	"viz. #value:"
	| γ θ appSort f_x f x |
	γ := Context currentElabEnv.

	θ := Z3Sort unify1: γ maybeExpr: nil tvSubst: TVSubst new sort: sort sort: s.
	γ senv sort at: name put: s.
	^s mkConst: name
	"Do NOT #note:elaboratedTo: because that would replace things like (list 'a)
	 with the concrete (list ℤ) even in other subexpressions."
	
	"appSort := FxEApp expr: sort instantiate imm: s.
	f_x := appSort elab: 2222 .
	f := f_x first withName: name.
	Context currentElabEnv senv sort note: sort elaboratedTo: f.
	^f"
]

{ #category : #'as yet unclassified' }
PreConstant >> value: arg [
	"We got here because we were in #elab: and hit something that requires
	 #evaluateIn:.  The Smalltalk compiler has compiled the source and now
	 we are symbolically running it to elab: the present (EApp self arg)."
	| appSort f_x f x |
	appSort := EApp expr: sort instantiate imm: arg sort.
	f_x := appSort elab: Context currentElabEnv .
	f := f_x first withName: name.
	Context currentElabEnv senv sort note: sort elaboratedTo: f.
	x := arg toZ3Node.
	^f value: x
]

Class {
	#name : #Prog,
	#superclass : #Object,
	#instVars : [
		'options',
		'quals',
		'meas',
		'expr',
		'data'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
Prog class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Prog class >> quals: quals meas: meas expr: expr data: data options: options [
	^self basicNew
		quals: quals; meas: meas; expr: expr; data: data; options: options;
		yourself
]

{ #category : #accessing }
Prog >> data [
	^ data
]

{ #category : #accessing }
Prog >> data: anObject [
	data := anObject
]

{ #category : #accessing }
Prog >> expr [
	^ expr
]

{ #category : #accessing }
Prog >> expr: anObject [
	expr := anObject
]

{ #category : #GT }
Prog >> gtInspectorExprsIn: composite [
	<gtInspectorPresentationOrder: 50>

	^(expr gtInspectorTreeIn: composite)
		title: 'Expressions'
]

{ #category : #accessing }
Prog >> meas [
	^ meas
]

{ #category : #accessing }
Prog >> meas: anObject [
	meas := anObject
]

{ #category : #accessing }
Prog >> options [
	^ options
]

{ #category : #accessing }
Prog >> options: anObject [
	options := anObject
]

{ #category : #accessing }
Prog >> quals [
	^ quals
]

{ #category : #accessing }
Prog >> quals: anObject [
	quals := anObject
]

{ #category : #verification }
Prog >> solve [
	| vc |
	
	expr := expr inlineNonRecursiveReflects.
	
	vc := [self vcgen] runReader: #checkTermination initialState: (self options includes: #'check-termination').
	^vc solve
]

{ #category : #verification }
Prog >> vcgen [
	| env eL cstr query |
	env := ΓContext empEnv: meas typs: data.
	eL := expr elaborate: env.
	CGState reset.
	cstr := eL check: env rtype: TInt instance bTrue.
	query := HornQuery new.
	cstr addToQuery: query.
	CGInfo current cgiKVars do: [ :kVar | kVar addToQuery: query ].
	quals do: [ :q | q addToQuery: query ].
	query qCon: (Dictionary newFromAssociations: meas).	
	#(1 2 3) do: [ :j | query addPapp: j ].
	CGInfo current cgiDefs   do: [ :equ  | equ  addToQuery: query ].
	CGInfo current cgiConsts do: [ :con  | con  addToQuery: query ].
	CGInfo current cgiDefs isEmpty ifFalse: [
		HOpt rewrite addToQuery: query
	].
	^query
]

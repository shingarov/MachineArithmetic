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
	| expr′ env eL ps pqs cI c_cgi c cgi rfls syms c′ decs |
	expr′ := expr uniq2.
	env := ΓContext empEnv: meas typs: data.
	eL := expr′ elaborate: env.
	ps := #(1 2 3) collect: [ :j |
		| hcon |
		hcon := HCon papp: j.
		hcon symbol -> hcon sort
	].
	pqs := #(1 2 3) collect: [ :j | Qualifier pappQual: j ].
	cI := [ CstrAnd of: (data collect: [ :t | t checkData: env ]) ] runCG key.
	c_cgi := [ eL check: env rtype: TInt instance bTrue ] runCG.
	c := c_cgi key. cgi := c_cgi value.
	rfls := cgi cgiConsts.
	syms := Dictionary newFromAssociations: ps, meas, rfls.
	c′ := c strengthenInv: env.
	decs := data collect: #reflectData.
	^HornQuery
		mkQuery_qs: quals, pqs
		ks: cgi cgiKVars
		cstr: cI & c′
		syms: syms
		defs: cgi cgiDefs
		ddecls: decs
]

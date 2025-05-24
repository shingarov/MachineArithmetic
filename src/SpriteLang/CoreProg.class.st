Class {
	#name : #CoreProg,
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
CoreProg class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
CoreProg class >> quals: quals meas: meas expr: expr data: data options: options [
	^self basicNew
		quals: quals; meas: meas; expr: expr; data: data; options: options;
		yourself
]

{ #category : #'reduction to core' }
CoreProg >> core [
	^self
]

{ #category : #accessing }
CoreProg >> data [
	^ data
]

{ #category : #accessing }
CoreProg >> data: anObject [
	data := anObject
]

{ #category : #accessing }
CoreProg >> expr [
	^ expr
]

{ #category : #accessing }
CoreProg >> expr: anObject [
	expr := anObject
]

{ #category : #GT }
CoreProg >> gtInspectorExprsIn: composite [
	<gtInspectorPresentationOrder: 50>

	^(expr gtInspectorTreeIn: composite)
		title: 'Expressions'
]

{ #category : #accessing }
CoreProg >> meas [
	^ meas
]

{ #category : #accessing }
CoreProg >> meas: anObject [
	meas := anObject
]

{ #category : #accessing }
CoreProg >> options [
	^ options
]

{ #category : #accessing }
CoreProg >> options: anObject [
	options := anObject
]

{ #category : #accessing }
CoreProg >> quals [
	^ quals
]

{ #category : #accessing }
CoreProg >> quals: anObject [
	quals := anObject
]

{ #category : #verification }
CoreProg >> solve [
	| vc |
	vc := [self core vcgen] runReader: #checkTermination initialState: (self options includes: #'check-termination').
	^vc solve
]

{ #category : #verification }
CoreProg >> vcgen [
	| α expr′ data′ env eL ps pqs cI c_cgi c cgi rfls syms c′ decs |
	
	α := αRenames empty.	
	data′ := data collect: [ :datum | datum uniq2: α ].
	expr′ := expr uniq2: α.
	
	env := ΓContext empEnv: meas typs: data′.
	eL := expr′ elaborate: env.
	ps := #(1 2 3) collect: [ :j |
		| hcon |
		hcon := HCon papp: j.
		hcon symbol -> hcon sort
	].
	pqs := #(1 2 3) collect: [ :j | Qualifier pappQual: j ].
	cI := [ CstrAnd of: (data′ collect: [ :t | t checkData: env ]) ] runCG key.
	c_cgi := [ eL check: env rtype: TInt instance bTrue ] runCG.
	c := c_cgi key. cgi := c_cgi value.
	rfls := cgi cgiConsts.
	syms := Dictionary newFromAssociations: ps, meas, rfls.
	c′ := c strengthenInv: env.
	decs := data′ collect: #reflectData.
	^HornQuery
		mkQuery_qs: quals, pqs
		ks: cgi cgiKVars
		cstr: cI & c′
		syms: syms
		defs: cgi cgiDefs
		ddecls: decs
]

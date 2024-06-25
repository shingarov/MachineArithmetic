Class {
	#name : #Z3ParameterKind,
	#superclass : #SharedPool,
	#classVars : [
		'PK_BOOL',
		'PK_DOUBLE',
		'PK_INVALID',
		'PK_OTHER',
		'PK_STRING',
		'PK_SYMBOL',
		'PK_UINT'
	],
	#category : #'Z3-Core'
}

{ #category : #initialization }
Z3ParameterKind class >> initialize [
	"
	See `Z3_param_kind` in `z3_api.h` [1]. Unfortunately,
	enum values are not explicit so may change. There's
	little to be done about this.

	[1] https://github.com/Z3Prover/z3/blob/cb50dca/src/api/z3_api.h#L1324-L1344
	"

	PK_UINT := 0.
	PK_BOOL := 1.
	PK_DOUBLE := 2.
	PK_SYMBOL := 3.
	PK_STRING := 4.
	PK_OTHER := 5.
	PK_INVALID := 6.
]

{ #category : #utilities }
Z3ParameterKind class >> kindToName: kind [
	"Translate parameter kind to human-readable name"

	kind isInteger ifFalse: [
		self error:'Invalid parameter kind: ', kind printString.
		^ nil.
	].

	^ #(
		'unsigned int'
		'bool'
		'double'
		'symbol'
		'string'
		'internal'
		'invalid'
	) at: kind + 1 ifAbsent: [ self error:'Invalid parameter kind: ', kind printString. nil ]

	"
	Z3ParameterKind kindToName: PK_UINT
	Z3ParameterKind kindToName: PK_SYMBOL
	"
]

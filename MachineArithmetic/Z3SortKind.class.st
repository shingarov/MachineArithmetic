"
The different kinds of Z3 types
"
Class {
	#name : #Z3SortKind,
	#superclass : #SharedPool,
	#classVars : [
		'ARRAY_SORT',
		'BOOL_SORT',
		'BV_SORT',
		'DATATYPE_SORT',
		'FINITE_DOMAIN_SORT',
		'FLOATING_POINT_SORT',
		'INT_SORT',
		'REAL_SORT',
		'RELATION_SORT',
		'RE_SORT',
		'ROUNDING_MODE_SORT',
		'SEQ_SORT',
		'UNINTERPRETED_SORT',
		'UNKNOWN_SORT'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #utilities }
Z3SortKind class >> astClassForSort: t [
	| sortKind |

	sortKind := LibZ3 uniqueInstance getSortKind: t ctx sort: t.
	sortKind = BOOL_SORT ifTrue: [ ^ Bool ].
	sortKind = BV_SORT ifTrue: [ ^ BitVector ].
	sortKind = INT_SORT ifTrue: [ ^ Int ].
	sortKind = REAL_SORT ifTrue: [ ^ Real ].
	sortKind = ARRAY_SORT ifTrue: [ ^ McCarthyArray ].
	sortKind = UNINTERPRETED_SORT ifTrue: [ ^ Uninterpreted ].

	self error: '(Yet) unssupported sort kind'

]

{ #category : #initialization }
Z3SortKind class >> initialize [
	"See z3_api.h [1]

	 [1]: https://github.com/Z3Prover/z3/blob/a52b485d9c27c4c7cd26f47fdf878b264900a0a6/src/api/z3_api.h#L149-L165
	"

	UNINTERPRETED_SORT := 0.
	BOOL_SORT := 1.
	INT_SORT := 2.
	REAL_SORT := 3.
	BV_SORT := 4.
	ARRAY_SORT := 5.
	DATATYPE_SORT := 6.
	RELATION_SORT := 7.
	FINITE_DOMAIN_SORT := 8.
	FLOATING_POINT_SORT := 9.
	ROUNDING_MODE_SORT := 10.
	SEQ_SORT := 11.
	RE_SORT := 12.
	UNKNOWN_SORT := 1000.

]

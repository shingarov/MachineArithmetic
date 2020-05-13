"
The different kinds of Z3 types
"
Class {
	#name : #SortKind,
	#superclass : #Object,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'known names' }
SortKind class >> ARRAY [
	"Z3_sort_kind::Z3_ARRAY_SORT"
	^5
]

{ #category : #'known names' }
SortKind class >> BOOL [
	"Z3_sort_kind::Z3_BOOL_SORT"
	^1
]

{ #category : #'known names' }
SortKind class >> BV [
	"Z3_sort_kind::Z3_BV_SORT"
	^4
]

{ #category : #'known names' }
SortKind class >> DATATYPE [
	"Z3_sort_kind::Z3_DATATYPE_SORT"
	^6

]

{ #category : #'known names' }
SortKind class >> FINITE_DOMAIN [
	"Z3_sort_kind::Z3_FINITE_DOMAIN_SORT"
	^8
]

{ #category : #'known names' }
SortKind class >> FLOATING_POINT [
	"Z3_sort_kind::Z3_FLOATING_POINT_SORT"
	^9
]

{ #category : #'known names' }
SortKind class >> INT [
	"Z3_sort_kind::Z3_INT_SORT"
	^2
]

{ #category : #'known names' }
SortKind class >> RE [
	"Z3_sort_kind::Z3_RE_SORT"
	^12
]

{ #category : #'known names' }
SortKind class >> REAL [
	"Z3_sort_kind::Z3_REAL_SORT"
	^3
]

{ #category : #'known names' }
SortKind class >> RELATION [
	"Z3_sort_kind::Z3_RELATION_SORT"
	^7
]

{ #category : #'known names' }
SortKind class >> ROUNDING_MODE [
	"Z3_sort_kind::Z3_ROUNDING_MODE_SORT"
	^10
]

{ #category : #'known names' }
SortKind class >> SEQ [
	"Z3_sort_kind::Z3_SEQ_SORT"
	^11
]

{ #category : #'known names' }
SortKind class >> UNINTERPRETED [
	"Z3_sort_kind::Z3_UNINTERPRETED_SORT"
	^0
]

{ #category : #'known names' }
SortKind class >> UNKNOWN [
	"Z3_sort_kind::Z3_UNKNOWN_SORT"
	^1000

]

{ #category : #'known names' }
SortKind class >> astClassDictionary [
	^Dictionary new 
		at: self BOOL     put: Bool;
		at: self BV       put: BitVector;
		at: self INT      put: Int;
		at: self REAL     put: Real;
		at: self ARRAY    put: McCarthyArray;
		at: self UNINTERPRETED put: Uninterpreted;
		yourself

]

{ #category : #'known names' }
SortKind class >> astClassForSort: t [
	| code |
	code := LibZ3 uniqueInstance getSortKind: t ctx sort: t.
	^self astClassDictionary at: code
]

{ #category : #'known names' }
SortKind class >> names [
	#(ARRAY BOOL BV DATATYPE FINITE_DOMAIN FLOATING_POINT INT RE REAL RELATION ROUNDING_MODE SEQ UNINTERPRETED UNKNOWN)
]

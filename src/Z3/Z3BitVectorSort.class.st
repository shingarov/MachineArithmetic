Class {
	#name : #Z3BitVectorSort,
	#superclass : #Z3Sort,
	#instVars : [
		'smin',
		'smax',
		'umax'
	],
	#category : #'Z3-Core'
}

{ #category : #inhabitation }
Z3BitVectorSort >> anyOne [
	^0 /// self length
]

{ #category : #'type theory' }
Z3BitVectorSort >> cast: value [
	^ value toBitVector: self length
]

{ #category : #initialization }
Z3BitVectorSort >> initializeWithAddress: anExternalAddress context: aZ3Context [
	| len |

	super initializeWithAddress: anExternalAddress context: aZ3Context.

	len := self length.

	umax := (1 << len) - 1.
	smin := (1 << (len - 1)) negated.
	smax := umax + smin.
]

{ #category : #accessing }
Z3BitVectorSort >> length [
	"Return length in bits"
	^ Z3 get_bv_sort_size: ctx _: self

]

{ #category : #'type theory' }
Z3BitVectorSort >> nodeClass [
	^ BitVector

]

{ #category : #printing }
Z3BitVectorSort >> printString [
	^ 'Z3Sort bv:',self length printString

]

{ #category : #'accessing - limits' }
Z3BitVectorSort >> smaxVal [
	^ smax
]

{ #category : #'accessing - limits' }
Z3BitVectorSort >> sminVal [
	^ smin
]

{ #category : #'accessing - limits' }
Z3BitVectorSort >> umaxVal [
	^ umax
]

{ #category : #'accessing - limits' }
Z3BitVectorSort >> uminVal [
	^ 0
]

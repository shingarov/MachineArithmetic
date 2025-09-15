Class {
	#name : #FloatingPoint,
	#superclass : #Z3Node,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
FloatingPoint class >> sym: variableNameString length: xlen [

	^ self var: variableNameString ofSort: Z3Sort float
]

{ #category : #arithmetic }
FloatingPoint >> * rhs [

	^ self mul: rhs roundingMode: self defaultRoundingMode
]

{ #category : #arithmetic }
FloatingPoint >> + rhs [

	^ self add: rhs roundingMode: self defaultRoundingMode
]

{ #category : #arithmetic }
FloatingPoint >> - rhs [

	^ self sub: rhs roundingMode: self defaultRoundingMode
]

{ #category : #arithmetic }
FloatingPoint >> / rhs [

	^ self div: rhs roundingMode: self defaultRoundingMode
]

{ #category : #arithmetic }
FloatingPoint >> < rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_lt: ctx _: self _: rhs.
	].
	^self retry: #< coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> <= rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_leq: ctx _: self _: rhs.
	].
	^self retry: #<= coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> > rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_gt: ctx _: self _: rhs.
	].
	^self retry: #> coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> >= rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_geq: ctx _: self _: rhs.
	].
	^self retry: #>= coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> abs [

	^ Z3 mk_fpa_abs: ctx _: self
]

{ #category : #arithmetic }
FloatingPoint >> add: rhs roundingMode: roundingMode [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_add: ctx _: roundingMode _: self _: rhs
	].
	^self retry: #add:roundingMode: with: roundingMode coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> defaultRoundingMode [

	^ Z3 mk_fpa_round_nearest_ties_to_away: ctx
]

{ #category : #arithmetic }
FloatingPoint >> div: rhs roundingMode: roundingMode [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_div: ctx _: roundingMode _: self _: rhs
	].
	^self retry: #div:roundingMode: with: roundingMode coercing: rhs
]

{ #category : #operations }
FloatingPoint >> eq: rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_eq: ctx _: self _: rhs.
	].
	^self retry: #eq: coercing: rhs
]

{ #category : #testing }
FloatingPoint >> isInfinite [
	
	^ Z3 mk_fpa_is_infinite: ctx _: self
]

{ #category : #testing }
FloatingPoint >> isNaN [
	
	^ Z3 mk_fpa_is_nan: ctx _: self
]

{ #category : #arithmetic }
FloatingPoint >> isNegative [

	^ Z3 mk_fpa_is_negative: ctx _: self
]

{ #category : #arithmetic }
FloatingPoint >> isNormal [

	^ Z3 mk_fpa_is_normal: ctx _: self
]

{ #category : #arithmetic }
FloatingPoint >> isPositive [

	^ Z3 mk_fpa_is_positive: ctx _: self
]

{ #category : #testing }
FloatingPoint >> isSubnormal [
	
	^ Z3 mk_fpa_is_subnormal: ctx _: self
]

{ #category : #arithmetic }
FloatingPoint >> isZero [

	^ Z3 mk_fpa_is_zero: ctx _: self
]

{ #category : #accessing }
FloatingPoint >> length [

	^ self sort length
]

{ #category : #arithmetic }
FloatingPoint >> max: rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_max: ctx _: self _: rhs.
	].
	^self retry: #max: coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> min: rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_min: ctx _: self _: rhs.
	].
	^self retry: #min: coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> mul: rhs roundingMode: roundingMode [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_mul: ctx _: roundingMode _: self _: rhs
	].
	^self retry: #mul:roundingMode: with: roundingMode coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> neg [

	^ Z3 mk_fpa_neg: ctx _: self
]

{ #category : #arithmetic }
FloatingPoint >> rem: rhs [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_rem: ctx _: self _: rhs.
	].
	^self retry: #rem: coercing: rhs
]

{ #category : #adapting }
FloatingPoint >> retry: selector coercing: rhs [
	
	^ self perform: selector with: (rhs toFloatingPoint: self length)
]

{ #category : #adapting }
FloatingPoint >> retry: selector with: anotherVal coercing: rhs [
	
	^ self perform: selector with: (rhs toFloatingPoint: self length) with: anotherVal
]

{ #category : #arithmetic }
FloatingPoint >> sqrt [

	^ self sqrt: self defaultRoundingMode
]

{ #category : #arithmetic }
FloatingPoint >> sqrt: roundingMode [

	^ Z3 mk_fpa_sqrt: ctx _: roundingMode _: self
]

{ #category : #arithmetic }
FloatingPoint >> sub: rhs roundingMode: roundingMode [

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_fpa_sub: ctx _: roundingMode _: self _: rhs
	].
	^self retry: #sub:roundingMode: with: roundingMode coercing: rhs
]

{ #category : #arithmetic }
FloatingPoint >> toBitVector [

	^ (Z3 mk_fpa_to_ieee_bv: ctx _: self) simplify
]

{ #category : #arithmetic }
FloatingPoint >> toBitVector: length [

	length = self length ifFalse: [ self error: 'bit length mismatch' ].

	^ self toBitVector
]

{ #category : #accessing }
FloatingPoint >> toFloatingPoint: length [

	length = self length ifFalse: [ self error: 'bit length mismatch' ].

	^ self
]

{ #category : #evaluating }
FloatingPoint >> value [

	^ [ Z3 get_numeral_double: ctx _: self ] onErrorDo: [ ^ self ]
]

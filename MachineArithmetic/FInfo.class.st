Class {
	#name : #FInfo,
	#superclass : #HornInfo,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #logic }
FInfo >> convertFormat [
	"Convert FInfo query to SInfo."
	| bindm_fi1 fi1 |
	bindm_fi1 := cm injectWithKey: (Dictionary new -> self) into: [ :m_fi :i :c | c outVV: m_fi i: i ].
	fi1 := bindm_fi1 value.
	fi1 cm: (fi1 cm collect: [ :subc | subc toSimpC: bindm_fi1 key ]).
	^fi1 as: SInfo 
]

{ #category : #'as yet unclassified' }
FInfo >> reduce [
	^self "BOGUS, should implement"
]

{ #category : #'as yet unclassified' }
FInfo >> remakeQual [
	"Destructively remake quals."
	quals := quals collect: [ :qual | qual remake ].
	^self
]

{ #category : #logic }
FInfo >> simplify [
	^self reduce remakeQual
]

{ #category : #logic }
FInfo >> solve [
	| si0 si1 si2 si3 si4 si5 si6 |
	si0 := self simplify convertFormat.
	si1 := si0 "sanitize".
	si2 := si1 wfcUniqify.
	si3 := si2 "renameAll".
	si4 := si3 "defunctionalize".
	si5 := si4 "elaborate".
	si6 := si5 "expand, if extensionality".
	"if rewrite axioms, instantiate then ^#Nothing"
	^si6 solve
	
]

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

{ #category : #GT }
FInfo >> gtInspectorBindsIn: composite [
	<gtInspectorPresentationOrder: 20>
	^bs gtInspectorBindsIn: composite
]

{ #category : #logic }
FInfo >> simplify [
	^self "BOGUS, must implement"
	
]

{ #category : #logic }
FInfo >> solve [
	^self simplify convertFormat solve
	
]

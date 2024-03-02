Class {
	#name : #ECase,
	#superclass : #'ΛExpression',
	#instVars : [
		'x',
		'alts'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ECase class >> x: x alts: alts [
	^self basicNew
		x: x;
		alts: alts;
		yourself
]

{ #category : #accessing }
ECase >> alts [
	^ alts
]

{ #category : #accessing }
ECase >> alts: anObject [
	alts := anObject
]

{ #category : #verification }
ECase >> check: Γ rtype: t [
" 
      Γ | y ⊦ a_i <== t
      ---------------------------- [Chk-Switch]
      Γ ⊦ Switch y {a_1...} <== t
"
	^CstrAnd of: (alts collect: [ :eachAlt | Γ checkAlt: x rType: t alt: eachAlt ] )
]

{ #category : #polymorphism }
ECase >> elabC: Γ rtype: t [
	| alts1 |
	alts1 := alts collect: [ :eachAlt | eachAlt elabAlt: Γ ident: x rtype: t ].
	^ECase x: x alts: alts1
]

{ #category : #'as yet unclassified' }
ECase >> goSubsTyExpr: su [ 
	^ECase x: x alts: (alts collect: [ :eachAlt |
		" goA "
		eachAlt copy
			expr: (eachAlt expr goSubsTyExpr: su);
			yourself
		])
]

{ #category : #GT }
ECase >> gtChildren [
	^alts
]

{ #category : #accessing }
ECase >> x [
	^ x
]

{ #category : #accessing }
ECase >> x: anObject [
	x := anObject
]

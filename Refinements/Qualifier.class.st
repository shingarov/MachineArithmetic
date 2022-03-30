Class {
	#name : #Qualifier,
	#superclass : #HThing,
	#instVars : [
		'name',
		'params',
		'body'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Qualifier class >> name: aString params: aCollection body: pred [
	^self basicNew
		name: aString;
		params: aCollection;
		body: pred;
		yourself

]

{ #category : #'instance creation' }
Qualifier class >> true [
	^self name: 'QTrue' params: #() body: nil
]

{ #category : #'as yet unclassified' }
Qualifier >> addToQuery: q [
	q qualifiers add: self
]

{ #category : #accessing }
Qualifier >> body [
	^ body
]

{ #category : #accessing }
Qualifier >> body: anObject [
	body := anObject
]

{ #category : #'as yet unclassified' }
Qualifier >> eQual: xs [
"
eQual :: Qualifier -> [Symbol] -> EQual
cf. Types/Solutions.hs
"
	| qxs p es su |
	qxs := params collect: #symbol.
	es := xs collect: #toEVar.
	su := Subst mkSubst: (qxs zip: es).
	p := body subst: su.
	^EQual qual: self pred: p args: es
]

{ #category : #'as yet unclassified' }
Qualifier >> evaluateIn: aBindEnv [ 
	^Qualifier
		name: name
		params: (params "evaluate??")
		body: (body evaluateIn: aBindEnv)
]

{ #category : #accessing }
Qualifier >> name [
	^ name
]

{ #category : #accessing }
Qualifier >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Qualifier >> params [
	^ params
]

{ #category : #accessing }
Qualifier >> params: anObject [
	params := anObject
]

{ #category : #printing }
Qualifier >> printOn: aStream [
	aStream nextPutAll: 'qualif '.
	aStream nextPutAll: name.
	aStream nextPutAll: ' ('.
	params printOn: aStream delimiter: ', '.
	aStream nextPutAll: ') '.
	body printOn: aStream
]

{ #category : #'as yet unclassified' }
Qualifier >> remake [
	"BOGUS, should implement"
	^self
]

{ #category : #'as yet unclassified' }
Qualifier >> sig [
	"Answer the receiver's QCSig, which is just a sequence of QualParam's.
	cf. qualSig."
	^params collect: [ :p | p eraseSymbol ]
]

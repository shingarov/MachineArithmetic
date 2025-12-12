Class {
	#name : #RRTyConstraintRep,
	#superclass : #Object,
	#instVars : [
		'env',
		'tl',
		'tr'
	],
	#category : #Metalanguage
}

{ #category : #'instance creation' }
RRTyConstraintRep class >> env: env tl: tl tr: tr [
	^self basicNew
		env: env;
		tl: tl;
		tr: tr;
		yourself
]

{ #category : #accessing }
RRTyConstraintRep >> env [
	^ env
]

{ #category : #accessing }
RRTyConstraintRep >> env: anObject [
	env := anObject
]

{ #category : #parsing }
RRTyConstraintRep >> rrTy: rhsType [
"
rrTy :: RType c tv r -> RType c tv r -> RType c tv r
          ct             rhs
Cf. liquidhaskell/src/Language/Haskell/Liquid/Parse.hs

Caveat programmator:  Unlike LH, we do not go through the RTypeRep dance.
Therefore in Smalltalk, ct is NOT an RType, but an RRTyConstraintRep.
"
	^RRTy_OCons
		env: env,
		     { HBind dummyName -> tl },
		     { HBind dummyName -> tr }		
		ty: rhsType
]

{ #category : #accessing }
RRTyConstraintRep >> tl [
	^ tl
]

{ #category : #accessing }
RRTyConstraintRep >> tl: anObject [
	tl := anObject
]

{ #category : #accessing }
RRTyConstraintRep >> tr [
	^ tr
]

{ #category : #accessing }
RRTyConstraintRep >> tr: anObject [
	tr := anObject
]

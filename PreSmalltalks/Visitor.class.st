"
I represent a generalization of #inject:into: enough to express calculations over arbitrary data structures.
See https://okmij.org/ftp/tagless-final/course/Boehm-Berarducci.html
"
Class {
	#name : #Visitor,
	#superclass : #Object,
	#instVars : [
		'txExpr',
		'accExpr'
	],
	#category : #PreSmalltalks
}

{ #category : #'instance creation' }
Visitor class >> defaultAccumulating: aMonoidalClass [
	^self
		txExpr: BlockClosure id
		accExpr: [ :x | aMonoidalClass new ]
]

{ #category : #'instance creation' }
Visitor class >> defaultTransforming: aBlock [
	^self
		txExpr: aBlock
		accExpr: [ :x | #() ]
]

{ #category : #'instance creation' }
Visitor class >> txExpr: txExpr accExpr: accExpr [
	^self basicNew
		txExpr: txExpr;
		accExpr: accExpr;
		yourself
]

{ #category : #accessing }
Visitor >> accExpr [
	^ accExpr
]

{ #category : #accessing }
Visitor >> accExpr: anObject [
	accExpr := anObject
]

{ #category : #accessing }
Visitor >> txExpr [
	^ txExpr
]

{ #category : #accessing }
Visitor >> txExpr: anObject [
	txExpr := anObject
]

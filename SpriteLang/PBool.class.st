Class {
	#name : #PBool,
	#superclass : #'ΛPrim',
	#instVars : [
		'bool'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
PBool class >> bool: bool [
	^self basicNew bool: bool; yourself 
]

{ #category : #accessing }
PBool >> bool [
	^ bool
]

{ #category : #accessing }
PBool >> bool: anObject [
	bool := anObject
]

{ #category : #'as yet unclassified' }
PBool >> constTy [

"
constTy _ (PBool True)  = TBase TBool (F.propReft F.PTrue)
constTy _ (PBool False) = TBase TBool (F.propReft F.PFalse)
"
	^bool
		ifTrue: [ TBool instance bTrue ]
		ifFalse: [ TBool instance bFalse ]

]

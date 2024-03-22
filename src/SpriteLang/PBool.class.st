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

{ #category : #selfification }
PBool >> constTy [

"
constTy _ (PBool True)  = TBase TBool (known $ F.propReft F.PTrue)
constTy _ (PBool False) = TBase TBool (known $ F.propReft F.PFalse)
"
	^TBase b: TBool instance r: bool propReft known

]

{ #category : #'as yet unclassified' }
PBool >> immExprX [
	^bool toBool
]

{ #category : #printing }
PBool >> spriteOn: aStream indent: level [
	bool printOn: aStream
]

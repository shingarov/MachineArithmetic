"
-- | Refinement Variables -----------------------------------------------------
data RVar = RVar
  { rvName :: F.Symbol
  , rvArgs :: ![RSort]
  }
  deriving (Eq, Show)
"
Class {
	#name : #RVar,
	#superclass : #Object,
	#instVars : [
		'rvName',
		'rvArgs'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
RVar class >> rvName: rvName rvArgs: rvArgs [
	^self basicNew
		rvName: rvName;
		rvArgs: rvArgs;
		yourself
	
]

{ #category : #accessing }
RVar >> rvArgs [
	^ rvArgs
]

{ #category : #accessing }
RVar >> rvArgs: anObject [
	rvArgs := anObject
]

{ #category : #accessing }
RVar >> rvName [
	^ rvName
]

{ #category : #accessing }
RVar >> rvName: anObject [
	rvName := anObject
]

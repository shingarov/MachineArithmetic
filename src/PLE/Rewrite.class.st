"
data Rewrite  = SMeasure
  { smName  :: Symbol         -- eg. f
  , smDC    :: Symbol         -- eg. D
  , smArgs  :: [Symbol]       -- eg. xs
  , smBody  :: Expr           -- eg. e[xs]
  }
  deriving (Data, Eq, Ord, Show, Generic)
Cf. Constraints.hs
"
Class {
	#name : #Rewrite,
	#superclass : #Object,
	#instVars : [
		'smName',
		'smDC',
		'smArgs',
		'smBody'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
Rewrite class >> SMeasure: dcName dc: dc args: args body: body [
	^self basicNew
		smName: dcName;
		smDC: dc;
		smArgs: args;
		smBody: body;
		yourself
]

{ #category : #accessing }
Rewrite >> smArgs [
	^ smArgs
]

{ #category : #accessing }
Rewrite >> smArgs: anObject [
	smArgs := anObject
]

{ #category : #accessing }
Rewrite >> smBody [
	^ smBody
]

{ #category : #accessing }
Rewrite >> smBody: anObject [
	smBody := anObject
]

{ #category : #accessing }
Rewrite >> smDC [
	^ smDC
]

{ #category : #accessing }
Rewrite >> smDC: anObject [
	smDC := anObject
]

{ #category : #accessing }
Rewrite >> smName [
	^ smName
]

{ #category : #accessing }
Rewrite >> smName: anObject [
	smName := anObject
]

"
data DataField = DField
  { dfName :: !LocSymbol          -- ^ Field Name
  , dfSort :: !Sort               -- ^ Field Sort
  } deriving (Eq, Ord, Show, Data, Typeable, Generic)


"
Class {
	#name : #DataField,
	#superclass : #Object,
	#instVars : [
		'dfName',
		'dfSort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DataField class >> dfName: dfName dfSort: dfSort [
	^self basicNew
		dfName: dfName;
		dfSort: dfSort;
		yourself
]

{ #category : #accessing }
DataField >> dfName [
	^ dfName
]

{ #category : #accessing }
DataField >> dfName: anObject [
	dfName := anObject
]

{ #category : #accessing }
DataField >> dfSort [
	^ dfSort
]

{ #category : #accessing }
DataField >> dfSort: anObject [
	dfSort := anObject
]

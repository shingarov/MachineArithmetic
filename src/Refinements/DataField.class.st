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

{ #category : #'SMT interface' }
DataField >> apply: ts [ 
	| θ |
	θ := Dictionary
		newFromAssociations: (ts collectWithIndex: [ :t :idx | idx-1 -> t ]).
	^DataField
		dfName: dfName
		dfSort: (dfSort apply: θ)
]

{ #category : #'SMT interface' }
DataField >> declarationAssociation: aMonomorphizedDataDecl in: γ [

	^dfName -> (dfSort monomorphicDeclIn: γ)
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

{ #category : #theories }
DataField >> fieldSelector: d [
"
fieldSelector :: DataDecl -> DataField -> (Symbol, Sort)
                    d          self
"
	| ft n |
	ft := dfSort fldSort: d.
	n := d ddVars.
	^self symbol -> (Z3Sort mkFFunc: n sorts: {d selfSort . ft})
]

{ #category : #printing }
DataField >> printOn: aStream [
	aStream nextPutAll: 'DataField '.
	aStream nextPutAll: dfName.
	aStream nextPutAll: '::'.
	dfSort printOn: aStream
]

{ #category : #Symbolic }
DataField >> symbol [
"
instance Symbolic DataField where
  symbol = val . dfName
"
	^dfName
]

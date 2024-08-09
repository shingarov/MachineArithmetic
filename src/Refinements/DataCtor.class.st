"
data DataCtor = DCtor
  { dcName   :: !LocSymbol        -- ^ Ctor Name
  , dcFields :: ![DataField]      -- ^ Ctor Fields
  } deriving (Eq, Ord, Show, Data, Typeable, Generic)
"
Class {
	#name : #DataCtor,
	#superclass : #Object,
	#instVars : [
		'dcName',
		'dcFields'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DataCtor class >> dcName: dcName dcFields: dcFields [
	^self basicNew
		dcName: dcName;
		dcFields: dcFields;
		yourself
]

{ #category : #'SMT interface' }
DataCtor >> apply: ts [ 
	^DataCtor
		dcName: dcName
		dcFields: (dcFields collect: [ :field | field apply: ts ])
]

{ #category : #accessing }
DataCtor >> dcFields [
	^ dcFields
]

{ #category : #accessing }
DataCtor >> dcFields: anObject [
	dcFields := anObject
]

{ #category : #accessing }
DataCtor >> dcName [
	^ dcName
]

{ #category : #accessing }
DataCtor >> dcName: anObject [
	dcName := anObject
]

{ #category : #'SMT interface' }
DataCtor >> declare: aMonomorphizedDataDecl in: γ [
	aMonomorphizedDataDecl
			declare: dcName
			accessors: (dcFields collect: [ :field | field declarationAssociation: aMonomorphizedDataDecl in: γ ])
]

{ #category : #printing }
DataCtor >> printOn: aStream [
	aStream
		nextPutAll: '↪';
		nextPutAll: dcName;
		nextPutAll: '('.
	dcFields do:
		[ :df | aStream nextPutAll: df dfName; nextPutAll: '::'. df dfSort printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ',' ].
	aStream
		nextPutAll: ')'
]

{ #category : #Symbolic }
DataCtor >> symbol [
	^dcName
]

"
data DataDecl = DDecl
  { ddTyCon :: !FTycon            -- ^ Name of defined datatype
  , ddVars  :: !Int               -- ^ Number of type variables
  , ddCtors :: [DataCtor]         -- ^ Datatype Ctors. Invariant: type variables bound in ctors are greater than ddVars
  } deriving (Eq, Ord, Show, Data, Typeable, Generic)
"
Class {
	#name : #DataDecl,
	#superclass : #Object,
	#instVars : [
		'ddTyCon',
		'ddVars',
		'ddCtors'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DataDecl class >> ddTyCon: ddTyCon ddVars: ddVars ddCtors: ddCtors [
	^self basicNew
		ddTyCon: ddTyCon;
		ddVars: ddVars;
		ddCtors: ddCtors;
		yourself 
	
]

{ #category : #'as yet unclassified' }
DataDecl >> addToQuery: aNNFQuery [ 
	aNNFQuery qData add: self
]

{ #category : #'SMT interface' }
DataDecl >> apply: ts [
	"Given type-parametrized receiver ...@(0)...@(1)...,
	 and actual type parameters t₀, t₁, …, answer a DataDecl with
	 all formal type parameters substituted: ...t₀...t₁... ." 
	^DataDecl
		ddTyCon: (ddTyCon apply: ts)
		ddVars: 0
		ddCtors: (ddCtors collect: [ :ctor | ctor apply: ts])
]

{ #category : #accessing }
DataDecl >> ddCtors [
	^ ddCtors
]

{ #category : #accessing }
DataDecl >> ddCtors: anObject [
	ddCtors := anObject
]

{ #category : #accessing }
DataDecl >> ddTyCon [
	^ ddTyCon
]

{ #category : #accessing }
DataDecl >> ddTyCon: anObject [
	ddTyCon := anObject
]

{ #category : #accessing }
DataDecl >> ddVars [
	^ ddVars
]

{ #category : #accessing }
DataDecl >> ddVars: anObject [
	ddVars := anObject
]

{ #category : #GT }
DataDecl >> gtInspectorConstructorsIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite fastList
		title: 'Constructors';
		display: [ ddCtors ]
]

{ #category : #'SMT interface' }
DataDecl >> monomorphicDeclIn: γ [
	| known |
	known := [ Context readState: #knownMonomorphizedDecls ]
		on: NoAnswer
		do: [ :_ex | [ ^self monomorphicDeclIn: γ ] runReader: #knownMonomorphizedDecls initialState: Dictionary new ].
	^known
		at: ddTyCon symbol
		ifAbsentPut: [
			| mdd |
			mdd := MonomorphizedDataDecl named: ddTyCon symbol encodeUnsafe.
			known at: ddTyCon symbol put: mdd.
			ddCtors do: [ :ctor | ctor declare: mdd in: γ ].
			mdd
		]


	
]

{ #category : #printing }
DataDecl >> printOn: aStream [
	aStream nextPutAll: 'data '.
	aStream nextPutAll: self ddTyCon symbol
]

{ #category : #Symbolic }
DataDecl >> symbol [
"
instance Symbolic DataDecl where
  symbol = symbol . ddTyCon
"
	^ddTyCon symbol
]

{ #category : #'SMT interface' }
DataDecl >> z3sort: γ [
	ddVars = 0 ifFalse: [ self error ].
	^PreSort hotel
		at: ddTyCon symbol
		ifAbsentPut: [ (self monomorphicDeclIn: γ) create ]
]

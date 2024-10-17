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

{ #category : #construction }
DataDecl >> addToQuery: aNNFQuery [ 
	aNNFQuery qData add: self
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

{ #category : #'SMT monomorphisation' }
DataDecl >> instantiateZ3Sort: ts [
	| ctors z3datatypeSort |
	ctors := self smt2datactors: ts.
	z3datatypeSort := Z3DatatypeSort name: self symbol  constructors: ctors.
	ctors do: #delete.
	^z3datatypeSort
]

{ #category : #printing }
DataDecl >> printOn: aStream [
	aStream nextPutAll: 'data '.
	aStream nextPutAll: self ddTyCon symbol
]

{ #category : #'as yet unclassified' }
DataDecl >> smt2datactors: ts [
	^ddCtors collect: [ :ctor | ctor smt2ctor: ts ]
]

{ #category : #Symbolic }
DataDecl >> symbol [
"
instance Symbolic DataDecl where
  symbol = symbol . ddTyCon
"
	^ddTyCon symbol
]

"
I am a single constraint defining a KVar

type Hyp      = ListNE Cube

data Cube = Cube
  { cuBinds :: IBindEnv  -- ^ Binders       from defining Env
  , cuSubst :: Subst     -- ^ Substitutions from cstrs    Rhs
  , cuId    :: SubcId    -- ^ Id            of   defining Cstr
  , cuTag   :: Tag       -- ^ Tag           of   defining Cstr (DEBUG)
  } deriving (Generic, NFData)
"
Class {
	#name : #Cube,
	#superclass : #Object,
	#instVars : [
		'binds',
		'subst',
		'id'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Cube class >> binds: binds subst: subst id: id [
	^self basicNew
		binds: binds;
		subst: subst;
		id: id;
		yourself 

]

{ #category : #accessing }
Cube >> binds [
	^ binds
]

{ #category : #accessing }
Cube >> binds: anObject [
	binds := anObject
]

{ #category : #accessing }
Cube >> id [
	^ id
]

{ #category : #accessing }
Cube >> id: anObject [
	id := anObject
]

{ #category : #printing }
Cube >> printOn: aStream [
"
instance PPrint Cube where 
  pprintTidy _ c = 'Cube' <+> pprint (cuId c)

instance Show Cube where
show = showpp
"
	aStream nextPutAll: 'Cube '.
	self id printOn: aStream
]

{ #category : #accessing }
Cube >> subst [
	^ subst
]

{ #category : #accessing }
Cube >> subst: anObject [
	subst := anObject
]

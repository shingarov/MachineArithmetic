"
I represent one Horn Variable declaration within a HornQuery, e.g.
(var $k ((int) (`t)))

The OrderedCollection of HVars is traversed in HornQuery>>hornWfs to get the initial BindEnv and KVEnv.

Caveat programmator: there is an enormous naming confusion in Types.hs,
where Var stands for either the datatype (this is the meaning in this class)

data Var a = HVar 
  { hvName :: !F.Symbol                         -- ^ name of the variable $k1, $k2 etc.
  , hvArgs :: ![F.Sort] {- len hvArgs > 0 -}    -- ^ sorts of its parameters i.e. of the relation defined by the @HVar@
  , hvMeta :: a                                 -- ^ meta-data
  }
  deriving (Eq, Ord, Data, Typeable, Generic, Functor)

or one of the Pred's three the data constructors (that's RefVarApp).
"
Class {
	#name : #HVar,
	#superclass : #HThing,
	#instVars : [
		'name',
		'domain'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HVar class >> name: aString argSorts: sorts [
	^self basicNew
		name: aString;
		domain: sorts;
		yourself
]

{ #category : #adding }
HVar >> addToQuery: q [ 
	q addVar: self
]

{ #category : #accessing }
HVar >> domain [
	^ domain
]

{ #category : #accessing }
HVar >> domain: sorts [
	domain := sorts toProduct
]

{ #category : #'as yet unclassified' }
HVar >> formalArguments [
	"Invent unique names for the receiver's arguments, such as
	  nnf_argººκºº0,
	  nnf_argººκºº1,
	 etc.      ^
	           +--- kvar name
	 Associate each name to its sort.
	 Answer the Array of these associations (in argument order).
	"

	^self domain inventFormalArgumentsFor: self name
]

{ #category : #'as yet unclassified' }
HVar >> kvInfo: initialBindEnv [ 
	"Create a new instance of KVInfo based on self,
	insert args into initialBindEnv making a new BindEnv,
	and return the association (newBindEnv->newKVInfo).
	
	kvInfo :: F.BindEnv -> H.Var a -> (F.BindEnv, KVInfo a)
	Cf. Info.hs.
	"
	| xts x t xts1 be1_ids be1 ids wenv wrft wfc |
	xts := self formalArguments. "Array of Associations such as 'nnf_argººkºº0'->ℤ"
	x := xts first key.
	t := xts first value.
	xts1 := xts allButFirst.
	be1_ids := xts1
		colject: initialBindEnv
		into: [ :beSoFar :thisBinding | (beSoFar insertVar: thisBinding key sort: thisBinding value) reverse ].
	be1 := be1_ids key.
	ids := be1_ids value.
	wenv := IBindEnv from: ids.
	wrft := { x. t. name }.
	wfc := WfC new 
		env: wenv;
		rft: wrft;
		yourself.
	^be1 -> (KVInfo basicNew
		kvVar: name;
		kvParams: (xts collect: [ :xt | xt key]);
		kvWfC: wfc;
		domain: xts;
		yourself)
]

{ #category : #accessing }
HVar >> name [
	^ name
]

{ #category : #accessing }
HVar >> name: aString [
	name := aString
]

{ #category : #printing }
HVar >> printOn: aStream [
	aStream nextPutAll: '(var $'.
	aStream nextPutAll: name.
	aStream nextPutAll: ' '.
	domain printElementsOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'function application' }
HVar >> value [
	^self valueWithArguments: #()
]

{ #category : #'function application' }
HVar >> valueWithArguments: args [
	"Create a Smalltalk-side representation of the receiver
	 to args, without creating an actual Z3 APP_AST node.
	NB: Each arg must be a (literal or symbolic) constant
	(i.e. something like 'x' toInt); effectively forcing ANF."
	^RefVarApp var: self name args: (args collect: #sym)
]

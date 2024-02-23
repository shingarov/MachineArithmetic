"
Cf. Constraints.hs:
data Equation = Equ 
  { eqName :: !Symbol           -- ^ name of reflected function
  , eqArgs :: [(Symbol, Sort)]  -- ^ names of parameters
  , eqBody :: !Expr             -- ^ definition of body
  , eqSort :: !Sort             -- ^ sort of body
  , eqRec  :: !Bool             -- ^ is this a recursive definition
  }
  deriving (Data, Eq, Ord, Show, Generic)
"
Class {
	#name : #Equation,
	#superclass : #HThing,
	#instVars : [
		'eqName',
		'eqArgs',
		'eqBody',
		'eqSort',
		'eqRec'
	],
	#category : #'Refinements-Reflection'
}

{ #category : #'instance creation' }
Equation class >> mkEquation: f args: xts expr: e sort: out [
"
mkEquation :: Symbol -> [(Symbol, Sort)] -> Expr -> Sort -> Equation
                f              xts           e      out
mkEquation f xts e out = Equ f xts e out (f `elem` syms e)
"
	^self basicNew
		eqName: f;
		eqArgs: xts;
		eqBody: e;
		eqSort: out;
		eqRec: "(e syms includes: f)  BOGUS" false;
		yourself
]

{ #category : #adding }
Equation >> addToQuery: aHornQuery [ 
	aHornQuery qEqns add: self
]

{ #category : #'as yet unclassified' }
Equation >> eqArgNames [
"
eqArgNames :: Equation -> [Symbol]
"
	^eqArgs collect: #key
]

{ #category : #accessing }
Equation >> eqArgs [
	^ eqArgs
]

{ #category : #accessing }
Equation >> eqArgs: anObject [
	eqArgs := anObject
]

{ #category : #accessing }
Equation >> eqBody [
	^ eqBody
]

{ #category : #accessing }
Equation >> eqBody: anObject [
	eqBody := anObject
]

{ #category : #accessing }
Equation >> eqName [
	^ eqName
]

{ #category : #accessing }
Equation >> eqName: anObject [
	eqName := anObject
]

{ #category : #accessing }
Equation >> eqRec [
	^ eqRec
]

{ #category : #accessing }
Equation >> eqRec: anObject [
	eqRec := anObject
]

{ #category : #accessing }
Equation >> eqSort [
	^ eqSort
]

{ #category : #accessing }
Equation >> eqSort: anObject [
	eqSort := anObject
]

{ #category : #'F.Subable' }
Equation >> mapEqBody: f [
"
mapEqBody :: (Expr -> Expr) -> Equation -> Equation
                   f            self
"
	self shouldBeImplemented
]

{ #category : #printing }
Equation >> printOn: aStream [
	aStream
		nextPutAll: (eqRec ifTrue: ['Equ⟳"'] ifFalse: ['Equ "']);
		nextPutAll: eqName;
		nextPutAll: '"('.
	eqArgs
		do: [ :eachArg | aStream
				nextPutAll: eachArg key;
				nextPutAll: '∈'.
				eachArg value printOn: aStream ]
		separatedBy: [ aStream nextPut: $, ].
	aStream
		nextPutAll: ') {...}'
]

{ #category : #'F.Subable' }
Equation >> subst: su [
	self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
Equation >> substEq: env es: es [
"
Unfold or instantiate an equation at a particular list of
argument values. We must also substitute the sort-variables that appear
as coercions. See tests/proof/ple1.fq

substEq :: SEnv Sort -> Equation -> [Expr] -> Expr
"
	| su |
	su := Subst mkSubst: (self eqArgNames zip: es).
	^(self substEqCoerce: env es: es) subst: su
]

{ #category : #'F.Subable' }
Equation >> substa: su [
	self shouldBeImplemented
]

{ #category : #'F.Subable' }
Equation >> substf: su [
	self shouldBeImplemented
]

{ #category : #'F.Subable' }
Equation >> syms [
	self shouldBeImplemented
]

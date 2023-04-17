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
	#superclass : #Object,
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
Equation class >> mkEquation: f [
"
mkEquation :: Symbol -> [(Symbol, Sort)] -> Expr -> Sort -> Equation
mkEquation f xts e out = Equ f xts e out (f `elem` syms e)
"
]

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
		eqRec: (e syms includes: f);
		yourself
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

{ #category : #'F.Subable' }
Equation >> subst: su [
	self shouldBeImplemented
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

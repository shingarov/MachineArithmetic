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
		eqRec: (e syms includes: f);
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

{ #category : #Normalizable }
Equation >> normalize [
"
instance Normalizable Equation where
  normalize eq = eq {eqArgs = zip xs' ss, eqBody = normalizeBody (eqName eq) $ subst su $ eqBody eq }
    where
      su      = mkSubst $ zipWith (\x y -> (x,EVar y)) xs xs'
      (xs,ss) = unzip (eqArgs eq)
      xs'     = zipWith mkSymbol xs [0..]
      mkSymbol x i = x `suffixSymbol` intSymbol (eqName eq) i
"
	| xs ss xs′ body′ |
	xs := eqArgs unzipAssociations first.
	ss := eqArgs unzipAssociations last.
	xs′ := xs zip: (0 to: xs size-1) with: [ :x :i |
		"mkSymbol"
		x suffixSymbol: (eqName intSymbol: i) ].
	"BOGUS!!!  self shouldBeImplemented" "su, normalizeBody....".
	body′ := 
	ECon prim: (PInt integer: 42)
	"for ple0: EBin
		bop: #+
		left: (EVar of: 'xººadderºº0')
		right: (EVar of: 'yººadderºº1')".
	^self copy
		eqArgs: (xs′ zip: ss);
		eqBody: body′;
		yourself
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

{ #category : #'as yet unclassified' }
Equation >> substEqCoerce: env es: es [
"
substEqCoerce :: SEnv Sort -> Equation -> [Expr] -> Expr
                   env        eq=self       es
"
	| ts |
	ts := eqArgs collect: #value.
	"BOGUS, just example"
	^ECon prim: (PInt integer: 42)
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

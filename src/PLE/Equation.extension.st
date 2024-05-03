Extension { #name : #Equation }

{ #category : #'*PLE' }
Equation >> normalizeIn: sEnv [
"
instance Normalizable Equation where
  normalize eq = eq {eqArgs = zip xs' ss, eqBody = normalizeBody (eqName eq) $ subst su $ eqBody eq }
    where
      su      = mkSubst $ zipWith (\x y -> (x,EVar y)) xs xs'
      (xs,ss) = unzip (eqArgs eq)
      xs'     = zipWith mkSymbol xs [0..]
      mkSymbol x i = x `suffixSymbol` intSymbol (eqName eq) i
"
	| xs ss xs′ su body′ evalEnv |
	xs := eqArgs unzipAssociations first.
	ss := eqArgs unzipAssociations last.
	xs′ := xs zip: (0 to: xs size-1) with: [ :x :i |
		"mkSymbol"
		x suffixSymbol: (eqName intSymbol: i) ].
	evalEnv := EvalEnv ofSorts: (SEnv newFromAssociations: eqArgs), sEnv naturalTransformations.
	body′ := eqBody evaluateIn: evalEnv.
	body′ := body′ smt2: sEnv.
	su := Dictionary newFromAssociations:  (xs zip: xs′).
	body′ := body′ renameVariables: su.
	body′ := body′ normalizeBody: eqName.
	^self copy
		eqArgs: (xs′ zip: ss);
		eqBody: body′;
		yourself
]

{ #category : #'*PLE' }
Equation >> substEq: env es: es [
"
Unfold or instantiate an equation at a particular list of
argument values. We must also substitute the sort-variables that appear
as coercions. See tests/proof/ple1.fq

substEq :: SEnv Sort -> Equation -> [Expr] -> Expr
"
	| su coerc |
	su := Dictionary newFromAssociations: (self eqArgNames zip: es).
	coerc := self substEqCoerce: env es: es.
	^coerc inEnvironment: su
]

{ #category : #'*PLE' }
Equation >> substEqCoerce: env es: es [
"
substEqCoerce :: SEnv Sort -> Equation -> [Expr] -> Expr
                   env        eq=self       es
"
	"BOGUS"
	^eqBody
]

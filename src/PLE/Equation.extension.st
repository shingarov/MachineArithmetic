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
	| xs ss xs′ su body′ |
	xs := eqArgs unzipAssociations first.
	ss := eqArgs unzipAssociations last.
	xs′ := xs zip: (0 to: xs size-1) with: [ :x :i | x suffixSymbol: (eqName intSymbol: i) ].
	su := Subst mkSubst: (xs zip: xs′ with: [ :x :y | x -> (EVar of: y) ]).
	body′ := (eqBody subst: su) normalizeBody: eqName.
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
	| ts eTs coSub |
	ts := eqArgs collect: #value.
	eTs := es collect: [ :e | e sortExpr: env ].
	coSub := env mkCoSub: eTs xTs: ts.
	^coSub applyCoSub: eqBody
]

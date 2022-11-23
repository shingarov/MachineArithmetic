"
type ElabEnv  = (SymEnv, Env),
where
type Env      = Symbol -> SESearch Sort

cf. SortCheck.hs
"
Class {
	#name : #ElabEnv,
	#superclass : #Object,
	#instVars : [
		'senv',
		'env'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
ElabEnv class >> new [
	self shouldNotImplement
	
]

{ #category : #'instance creation' }
ElabEnv class >> symEnv: se env: e [
	^self basicNew
		senv: se;
		env: e;
		yourself
	
]

{ #category : #'as yet unclassified' }
ElabEnv >> elabAppSort: s1 _: s2 [ "missing expr args!!!"
"
elabAppSort :: Env -> Expr -> Expr -> Sort -> Sort -> CheckM (Expr, Expr, Sort, Sort, Sort)
"
	| g sIn_sOut_su sIn sOut su su_ |
	g := env.

	"e1 is the function we are applying"
	sIn_sOut_su := s1 checkFunSort. sIn := sIn_sOut_su first. sOut := sIn_sOut_su second. su := sIn_sOut_su third.
	su_ := Z3Sort unify1: g maybeExpr: nil tvSubst: su sort: sIn sort: s2.
	^{
		#bogusE1. "applyExpr (Just su') e1"
		#bogusE2. "applyExpr (Just su') e2"
		su_ applyTo: s1.
		su_ applyTo: s2.
		su_ applyTo: sOut
	}
	
]

{ #category : #'as yet unclassified' }
ElabEnv >> elabEApp: s1 _: s2 [
"
elabEApp  :: ElabEnv -> Expr -> Expr -> CheckM (Expr, Sort, Expr, Sort, Sort)
                                                e1''  s1'   e2''  s2'   s
"
	| e1xx_e2xx_s1x_s2x_s e1__ e2__ s1_ s2_ s |
	e1xx_e2xx_s1x_s2x_s := self elabAppSort: s1 _: s2. "WRONG!!!! the idea is that s1, s2 are determined from e1, e2"
	e1__ := e1xx_e2xx_s1x_s2x_s first.
	e2__ := e1xx_e2xx_s1x_s2x_s second.
	s1_  := e1xx_e2xx_s1x_s2x_s third.
	s2_  := e1xx_e2xx_s1x_s2x_s fourth.
	s    := e1xx_e2xx_s1x_s2x_s fifth.
	^{e1__. s1_. e2__. s2_. s}
]

{ #category : #accessing }
ElabEnv >> env [
	^ env
]

{ #category : #accessing }
ElabEnv >> env: anObject [
	env := anObject
]

{ #category : #accessing }
ElabEnv >> senv [
	^ senv
]

{ #category : #accessing }
ElabEnv >> senv: anObject [
	senv := anObject
]

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

{ #category : #elaboration }
ElabEnv >> elabAppSort: e1 _: e2 _: s1 _: s2 [
"
elabAppSort :: Env -> Expr -> Expr -> Sort -> Sort -> CheckM (Expr, Expr, Sort, Sort, Sort)
               self    e1      e2      s1      s2
"
	| g sIn_sOut_su sIn sOut su su_ |

	"e1 is the function we are applying"
	sIn_sOut_su := s1 checkFunSort. sIn := sIn_sOut_su first. sOut := sIn_sOut_su second. su := sIn_sOut_su third.
	su_ := Z3Sort unify1: env maybeExpr: (EApp expr: e1 imm: e2) tvSubst: su sort: sIn sort: s2.
	self notifyAboutTVSubst: su_.
	^{
		e1 applyExpr: su_.
		e2 applyExpr: su_.
		su_ applyTo: s1.
		su_ applyTo: s2.
		su_ applyTo: sOut
	}
	
]

{ #category : #elaboration }
ElabEnv >> elabEApp: e1 _: e2 [
"
elabEApp  :: ElabEnv -> Expr -> Expr -> CheckM (Expr, Sort, Expr, Sort, Sort)
               γ         e1      e2              e1''  s1'   e2''  s2'   s
"




	" used to be called  #value: --> #elab: --> here, like this
	
	| appSort f_x f x |
	appSort := EApp expr: sort instantiate imm: arg sort.
	f_x := appSort elab: Context currentElabEnv .
	f := f_x first withName: name.
	Context currentElabEnv senv sort note: sort elaboratedTo: f.
	x := arg toZ3Node.
	^f value: x"

	| e1x_s1 e2x_s2 e1x s1 e2x s2    e1xx_e2xx_s1x_s2x_s e1__ e2__ s1_ s2_ s |
	e1x_s1 := e1 elab: self. e1x := e1x_s1 first. s1 := e1x_s1 last.
	e2x_s2 := e2 elab: self. e2x := e2x_s2 first. s2 := e2x_s2 last.
	
	e1xx_e2xx_s1x_s2x_s := self elabAppSort: e1x _: e2x _: s1 _: s2.
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

{ #category : #elaboration }
ElabEnv >> notifyAboutTVSubst: aTVSubst [ 
	aTVSubst keysAndValuesDo: [ :i :s |
		self senv sort note: i "TODO: this should be (FVar new: i) but then the hacked representation by simply i must change in the other places too" elaboratedTo: s ]
]

{ #category : #accessing }
ElabEnv >> senv [
	^ senv
]

{ #category : #accessing }
ElabEnv >> senv: anObject [
	senv := anObject
]

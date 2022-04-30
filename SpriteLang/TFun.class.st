Class {
	#name : #TFun,
	#superclass : #RType,
	#instVars : [
		'x',
		's',
		't'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TFun class >> x: x s: s t: t [
	^self basicNew
		x: x; s: s; t: t; yourself 
]

{ #category : #'as yet unclassified' }
TFun >> freeTVarsGo [
	^s freeTVarsGo union: t freeTVarsGo
]

{ #category : #'as yet unclassified' }
TFun >> fresh: Γ [
	| s1 t1 Γ1 |
	s1 := s fresh: Γ.
	Γ1 := Γ extEnv: x rtype: s.
	t1 := t fresh: Γ1.
	^TFun x: x s: s1 t: t1
]

{ #category : #GT }
TFun >> gtChildren [
	^#()
]

{ #category : #printing }
TFun >> printOn: aStream [
	aStream
			nextPutAll: 'TFun ';
			nextPutAll: x;
			nextPutAll: ': '.
	s printOn: aStream.
	aStream nextPutAll: '=>'.
	t printOn: aStream.
	

]

{ #category : #accessing }
TFun >> s [
	^ s
]

{ #category : #accessing }
TFun >> s: anObject [
	s := anObject
]

{ #category : #polymorphism }
TFun >> strengthenTop: _r [
	^self
]

{ #category : #'as yet unclassified' }
TFun >> subsTy: su [
	| s_ t_ |
	s_ := s subsTy: su.
	t_ := t subsTy: su. 
	^TFun x: x s: s_ t: t_
]

{ #category : #'as yet unclassified' }
TFun >> subst1: toExpr for: fromVarName [ 
	^TFun
		x: x
		s: (s subst1: toExpr for: fromVarName)
		t: (t subst1: toExpr for: fromVarName)
]

{ #category : #accessing }
TFun >> t [
	^ t
]

{ #category : #accessing }
TFun >> t: anObject [
	t := anObject
]

{ #category : #polymorphism }
TFun >> tsubst: ty tVar: a [
"
tsubst :: TVar -> RType -> RType -> RType
           ^        ^        ^
           a       ty      self
bgs: ty because t is already taken
"
	^TFun
		x: x
		s: (s tsubst: ty tVar: a)
		t: (t tsubst: ty tVar: a)
]

{ #category : #'as yet unclassified' }
TFun >> unify: tfun2 [
	| x_ s_ t1_ t2_ t_ |
	x_ := x unifyX: tfun2 x.
	s_ := s unify: tfun2 s.
	t1_ := ElabState current subsTyM: t.
	t2_ := tfun2 t subsTyM.
	t_ := t1_ unify: t2_.
	^TFun x: x_ s: s_ t: t_
]

{ #category : #accessing }
TFun >> x [
	^ x
]

{ #category : #accessing }
TFun >> x: anObject [
	x := anObject
]

{ #category : #'as yet unclassified' }
TFun >> ≺ [ rhs
"
[Sub-Fun]  
       
       (v::t) => q[w := v]
       -------------------
       b{v:p} <: b{w:q}
  
      s2 <: s1    x2:s2 |- t1[x1:=x2] <: t2 
      -------------------------------------
      x1:s1 -> t1 <: x2:s2 -> t2
"
	| x2 s2 t2 t1_ cI cO |
	x2 := rhs x. s2 := rhs s. t2 := rhs t.
	t1_ := t subst1: (FxEVar of: x2) for: x.
	cI := s2 ≺ s.
	cO := s2 cAll: x2 cstr: t1_ ≺ t2.
	^cI & cO
]

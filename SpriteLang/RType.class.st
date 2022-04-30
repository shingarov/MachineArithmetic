"
Sprite's own concept of refined type.
It can either be of the form
  Int{r}
(because we only know about one base type, Z),
or of the form
  x:s -> t
where x is an identifier and s and t are SpriteRTypes.
"
Class {
	#name : #RType,
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #polymorphism }
RType >> assign: tVar [
	ElabState current updSub: tVar rtype: self
]

{ #category : #'as yet unclassified' }
RType >> cAll: symbol cstr: c [
"
cAll :: F.SrcSpan -> F.Symbol -> RType -> SrcCstr -> SrcCstr
cAll _ x t c = case sortPred x t of
  Just (so, p) -> H.All (H.Bind x so p) c
  _            -> c
"
	| so_p so p |
	so_p := self sortPred: symbol.
	so_p isNil ifTrue: [ ^c ].
	so := so_p first.
	p := so_p last.
	^CstrAll bind: (HBind x: symbol τ: so p: p) p: c
]

{ #category : #'as yet unclassified' }
RType >> freeTVars [
	^self freeTVarsGo asSortedCollection
]

{ #category : #'as yet unclassified' }
RType >> fresh: Γ [ 
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RType >> generalize [
	^self freeTVars reversed inject: self into: [ :typeSoFar :thisVar | TAll var: thisVar type: typeSoFar ]
]

{ #category : #GT }
RType >> gtChildren [
	^#()
]

{ #category : #'as yet unclassified' }
RType >> instantiate [
"instantiate :: RType -> ElabM ([RType], RType)"
	^self instantiateGo: #()
]

{ #category : #'as yet unclassified' }
RType >> instantiateGo: ts [
"cf. Elaborate.hs"
	^{ ts . self }
]

{ #category : #polymorphism }
RType >> singTvSub: a [ 
	^TvSub newFromAssociations: {a symbol -> self}
]

{ #category : #'synthesis constraints' }
RType >> singleton: x [
	^self
]

{ #category : #'as yet unclassified' }
RType >> sortPred: aString [ 
	^nil
]

{ #category : #'as yet unclassified' }
RType >> splitTAll [
	^{ #() . self }
]

{ #category : #polymorphism }
RType >> strengthenTop: r [
"strengthenTop :: RType -> Reft -> RType"
	^self subclassResponsibility
]

{ #category : #polymorphism }
RType >> subsTy1: a x: x [
	^x subsTy: (self singTvSub: a)
]

{ #category : #'as yet unclassified' }
RType >> subst1: aSpriteEVar for: aString [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
RType >> substImm: from imm: toImmExpr [
	^self subst1: toImmExpr for: from
]

{ #category : #'as yet unclassified' }
RType >> ≺ [ t
	self subclassResponsibility 
]

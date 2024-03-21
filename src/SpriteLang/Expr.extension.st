Extension { #name : #Expr }

{ #category : #'*SpriteLang' }
Expr >> gtBind [
	^''
]

{ #category : #'*SpriteLang' }
Expr >> gtExpr [
	^self
]

{ #category : #'*SpriteLang' }
Expr >> isLet [
	^false
]

{ #category : #'*SpriteLang' }
Expr >> nat [
	"for purposes of termination, am I...?"
	^self >= 0
]

{ #category : #'*SpriteLang' }
Expr >> okMetric [
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #okMetric))
		sort: Bool sort
]

{ #category : #'*SpriteLang' }
Expr >> predRType [
"
predRType :: F.Pred -> RType
predRType p = TBase TBool (known $ F.predReft p)
"
	^TBase
		b: TBool instance
		r: self "F."predReft known
]

{ #category : #'*SpriteLang' }
Expr >> wfMetric: γ [ 
	| v |
	v := self
		evaluateIn: (EvalEnv ofSorts: γ eSorts)
		ifUndeclared: [ ^false ]. "expected: we just haven't reached the fixpoint where n is put in γ "
	(v isKindOf: UnknownEVar) ifTrue: [ ^false ]. "BOGUS: what about non-atoms?"
	^v sort canBeTerminationMetric
]

{ #category : #'*SpriteLang' }
Expr >> uniq2: α [
	"α-rename all variables. Returns a copy of receiver with all names unique."

	| self′ |

	self′ := self.
	α keysAndValuesDo: [ :orig :uniq |
		self′ := self′ rename: orig to: uniq.
	].
	^ self′
]

{ #category : #'*SpriteLang' }
Expr >> ΛpredReft [
	^self predReft known
]

{ #category : #'*SpriteLang' }
Expr >> ⊲ [ pO 
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #⊲ argument: pO))
		sort: Bool sort
]

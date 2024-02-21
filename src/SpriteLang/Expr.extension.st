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
	^self >= 0
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

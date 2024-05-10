Extension { #name : #String }

{ #category : #'*SpriteLang' }
String class >> junkSymbol [
"
junkSymbol :: F.Symbol
junkSymbol = '_'
cf. Types.hs
"
	^'_'
]

{ #category : #'*SpriteLang' }
String >> nonRigid [
	^self beginsWith: 'fvºº'
]

{ #category : #'*SpriteLang' }
String >> predApp: xs [
"
predApp :: (F.Expression e) => F.Symbol -> [e] -> F.Expr
cf. Common.hs in Sprite
"
	| n pn |
	n := xs size.
	pn := n pappSym.

	^DecidableRefinement text: (
		xs inject: pn, ' value: ', self into: [ :soFar :thisArg | soFar, ' value: ', thisArg ]
	)
	"^pn toEVar eApps: {self toEVar}, (xs collect: #toEVar)"
]

{ #category : #'*SpriteLang' }
String >> rVar [
"
rVar :: F.Symbol -> RType
"
	^TBase b: (TVar symbol: self) r: ΛReft new
]

{ #category : #'*SpriteLang' }
String >> unifyX: anotherString [ 
	^self
]

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
	^EApp
		mkEApp: xs size pappSym
		args: ({self}, xs collect: #toEVar)
]

{ #category : #'*SpriteLang' }
String >> rVar [
"
rVar :: F.Symbol -> RType
"
	^(TVar symbol: self) bTrue
]

{ #category : #'*SpriteLang' }
String >> selDataCon: i [
"
selDataCon :: DaCon -> Int -> F.Symbol
"
	^self, '__', i printString "BOGUS, inconsistent with upstream; someone is doing double-escaping"
]

{ #category : #'*SpriteLang' }
String >> unifyX: anotherString [ 
	^self
]

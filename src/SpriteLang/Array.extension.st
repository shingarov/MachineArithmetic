Extension { #name : #Array }

{ #category : #'*SpriteLang' }
Array >> cImpl: p1 _: p2 [
	^(self collectAssociations: [ :x :t | x -> t rSortToFSort ]) cImplGo: p1 _: p2
]

{ #category : #'*SpriteLang' }
Array >> cImplGo: p1 _: p2 [
	| x t xts |
	"self can't be empty"
	x := self first key. t := self first value. xts := self allButFirst.
	^xts isEmpty
		ifTrue:  [ CstrAll bind: (HBind x: x τ: t p: p1) p: p2 cHead ]
		ifFalse: [ CstrAll bind: (HBind x: x τ: t p: HPred new) p: (xts cImplGo: p1 _: p2) ]
	
]

{ #category : #'*SpriteLang' }
Array >> tcInvs [
"
tcInvs :: [SrcData] -> F.SEnv Reft
"
	^SEnv newFromAssociations:
		((self select: [ :d |
				| inv |
				inv := d inv.
				inv isKnown and: [ inv expr pTrivial not ]
			]) collect: [ :d | d shouldBeImplemented ])
]

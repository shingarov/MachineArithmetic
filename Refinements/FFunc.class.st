"
I am a brain-damaged function Sort which is not a Z3Sort.

These get created by the funcSortP parser
(who is inside the sortP' parser which has the 'func' keyword:
sortP' appArgsP
   = ...
  <|> (reserved ""func"" >> funcSortP) -- function sort, starts with ""func""
   ...
), so funcSortP parses the parenthesized thing after 'func ':

funcSortP :: Parser Sort
funcSortP = parens $ mkFFunc <$> intP <* comma <*> sortsP
"
Class {
	#name : #FFunc,
	#superclass : #PreSort,
	#instVars : [
		'from',
		'to'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FFunc class >> from: dom to: cod [
	^self basicNew
		from: dom;
		to: cod;
		yourself
]

{ #category : #comparing }
FFunc >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^from = rhs from and: [ to = rhs to ]
]

{ #category : #yoneda }
FFunc >> apply: θ [
	^FFunc from: (from apply: θ) to: (to apply: θ)
]

{ #category : #'sort-checking' }
FFunc >> checkFunSort [
	"Deconstruct a (non-Z3) function-sort."
	^{ from . to . TVSubst new }
]

{ #category : #'as yet unclassified' }
FFunc >> containsFVar [
	^from containsFVar or: [ to containsFVar ]
]

{ #category : #accessing }
FFunc >> from [
	^ from
]

{ #category : #accessing }
FFunc >> from: anObject [
	from := anObject
]

{ #category : #'as yet unclassified' }
FFunc >> goFunctionSort: vs _: ss [
"
go vs ss (FFunc s1 s2) = go vs (s1:ss) s2
"
	^to goFunctionSort: vs _: {from}, ss
]

{ #category : #'as yet unclassified' }
FFunc >> goMapSort: stepBlock [
"cf. Visitor.hs"
	^FFunc from: (stepBlock value: from) to: (stepBlock value: to) 
]

{ #category : #comparing }
FFunc >> hash [
	^from hash
]

{ #category : #printing }
FFunc >> printOn: aStream [
	aStream nextPutAll: '(FFunc '.
	from printOn: aStream.
	aStream nextPutAll: ' → '.
	to printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #'sort-checking' }
FFunc >> sortSubst: θ [
"
sortSubst θ (FFunc t1 t2) = FFunc (sortSubst θ t1) (sortSubst θ t2)
"
	^θ at: self ifAbsent: [ 
		FFunc
			from: (from sortSubst: θ)
			to: (to sortSubst: θ)
	]
]

{ #category : #'sort-checking' }
FFunc >> subst: j _: tj [
	| t1′ t2′ |
	t1′ := from subst: j _: tj.
	t2′ := to   subst: j _: tj.
	^FFunc from: t1′ to: t2′
]

{ #category : #accessing }
FFunc >> to [
	^ to
]

{ #category : #accessing }
FFunc >> to: anObject [
	to := anObject
]

Class {
	#name : #FObj,
	#superclass : #PreSort,
	#instVars : [
		'symbol'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FObj class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
FObj class >> symbol: s [
	^self basicNew
		symbol: s;
		yourself
]

{ #category : #comparing }
FObj >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^symbol = rhs symbol
]

{ #category : #'as yet unclassified' }
FObj >> checkNumeric: f tvSubst: aCollection [
"
checkNumeric :: Env -> Sort -> CheckM ()
                 f     s@FObj(l)     ← s=self, l=symbol
checkNumeric f s@(FObj l)
  = do t <- checkSym f l
       unless (t `elem` [FNum, FFrac, intSort, FInt]) (throwErrorAt $ errNonNumeric s)
"
	| t |
	t := f checkSym: symbol.
	t isIntSort ifFalse: [ NonNumericSort signalForSort: t ].
	^nil
]

{ #category : #'as yet unclassified' }
FObj >> fappSmtSort: ts originalFApp: anFApp [
	^self z3sort fappSmtSort: ts originalFApp: anFApp
]

{ #category : #comparing }
FObj >> hash [
	^symbol hash
]

{ #category : #substitution }
FObj >> subst: j _: tj [ 
	^self
]

{ #category : #accessing }
FObj >> symbol [
	^ symbol
]

{ #category : #accessing }
FObj >> symbol: anObject [
	symbol := anObject
]

{ #category : #hotel }
FObj >> z3sort [
	^Z3Sort uninterpretedSortNamed: symbol
]

Class {
	#name : #'ΛοParser',
	#superclass : #'ΛκParser',
	#category : #'Metalanguage-Parsing'
}

{ #category : #grammar }
ΛοParser >> anfableExpr [
	"TODO: Issue#538:
	 why will parsing break if we simply say 'expr' here?"
	^ appExpr / letExpr / binExpr / imm
]

{ #category : #accessing }
ΛοParser >> progClass [
	^Prog
]

{ #category : #accessing }
ΛοParser >> switchExpr [
	^'switch' asParser trim,
	self anfableExpr parens trim,
	alt plus braces
	==> [ :x | ECase x: x second alts: x third ]
]

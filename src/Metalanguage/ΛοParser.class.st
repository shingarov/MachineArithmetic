Class {
	#name : #'ΛοParser',
	#superclass : #'ΛκParser',
	#category : #'Metalanguage-Parsing'
}

{ #category : #grammar }
ΛοParser >> anfableExpr [
	^ appExpr / imm
]

{ #category : #accessing }
ΛοParser >> progClass [
	^Prog
]

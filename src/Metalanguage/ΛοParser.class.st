Class {
	#name : #'ΛοParser',
	#superclass : #'ΛκParser',
	#category : #'Metalanguage-Parsing'
}

{ #category : #grammar }
ΛοParser >> appExpr [
	^ immExpr, (appExpr / imm) commaList
	==> [ :f_args |
		ΛEApp mkEApp: f_args first args: f_args second ]
]

{ #category : #accessing }
ΛοParser >> progClass [
	^Prog
]

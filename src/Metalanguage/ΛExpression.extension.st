Extension { #name : #'ΛExpression' }

{ #category : #'*Metalanguage' }
ΛExpression >> toANF [
	"Assuming the receiver has already been converted to Monadic form,
	 flatten it to Flanagan–Sabry–Felleisen Administrative Normal Form
	 ('The Essence of Compiling with Continuations', PLDI'93, see
	  https://dl.acm.org/doi/10.1145/155090.155113 "
	^self subclassResponsibility
]

{ #category : #'*Metalanguage' }
ΛExpression >> toMIF [
	"Answer the receiver normalized to MIF."
	^self subclassResponsibility
]

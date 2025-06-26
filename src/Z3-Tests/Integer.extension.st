Extension { #name : #Integer }

{ #category : #'*Z3-Tests' }
Integer >> equals: rhs modulo: m [
	^self - rhs \\ m = 0
]

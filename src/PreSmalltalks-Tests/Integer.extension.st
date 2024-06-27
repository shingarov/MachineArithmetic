Extension { #name : #Integer }

{ #category : #'*PreSmalltalks-Tests' }
Integer >> factorialHylomorphically [
	self < 0 ifTrue: [self error: 'Not valid for negative integers'].
	^(1 to: self) "anamorphism: unfold scalar to an inductive datatype"
		inject: 1 into: #* "catamorphism: fold inductive datatype to scalar"
]

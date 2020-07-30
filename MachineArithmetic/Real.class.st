Class {
	#name : #Real,
	#superclass : #AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Real class >> printSort: ty on: aStream [
	aStream nextPutAll: 'real'
]

{ #category : #adapting }
Real >> beLikeMe: value [
	^value toReal
]

{ #category : #adapting }
Real >> isReal [
	^true
]

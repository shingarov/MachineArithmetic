Class {
	#name : #EComputedTLApp,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #'Refinements-SortCheck'
}

{ #category : #elaboration }
EComputedTLApp >> ofSort: selfT applyTo: x ofSort: xT in: γ returning: _ [
	^self value: x
]

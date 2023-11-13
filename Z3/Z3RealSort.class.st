Class {
	#name : #Z3RealSort,
	#superclass : #Z3Sort,
	#category : #'Z3-Core'
}

{ #category : #'type theory' }
Z3RealSort >> cast: value [
	^ value toReal
]

{ #category : #'type theory' }
Z3RealSort >> nodeClass [
	^ Real

]

{ #category : #printing }
Z3RealSort >> printString [
	^String with: Character reals
]

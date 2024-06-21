Class {
	#name : #Maybe,
	#superclass : #Functor,
	#category : #Functors
}

{ #category : #'class initialization' }
Maybe class >> initialize [
	UndefinedObject changeSuperclassTo: Maybe
]

Class {
	#name : #Functor,
	#superclass : #Object,
	#category : #Functors
}

{ #category : #'class initialization' }
Functor class >> initialize [
	Collection changeSuperclassTo: Functor.
]

{ #category : #'Functor API' }
Functor >> collect: aMorphism [
	"Lift a morphism a→b to Fa→Fb.
	 The resulting morphism is expressed set-theoretically aka pointwise:
	 Assuming self is an element of Fa, and given the a→b,
	 answer an element of Fb.
	
	 Implementors of #collect: must respect identity and composition."

	^self subclassResponsibility
]

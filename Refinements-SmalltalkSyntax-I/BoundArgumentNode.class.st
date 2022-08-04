Class {
	#name : #BoundArgumentNode,
	#superclass : #RBArgumentNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'instance creation' }
BoundArgumentNode class >> concreteClassFor: quantifierCharacter [
	quantifierCharacter = $: ifTrue: [ ^LambdaArgumentNode ].              ":x"
	quantifierCharacter = $∀ ifTrue: [ ^UniversallyBoundVariableNode ].    "∀x"
	quantifierCharacter = $∃ ifTrue: [ ^ExistentiallyBoundVariableNode ].  "∃x"
	quantifierCharacter = $⋆ ifTrue: [ ^HornVariableNode ].                "⋆x"
]

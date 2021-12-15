"
I represent a strongly-connected component of a graph.
https://en.wikipedia.org/wiki/Strongly_connected_component

"
Class {
	#name : #SCC,
	#superclass : #Collection,
	#category : #DepthFirstSearch
}

{ #category : #adding }
SCC >> add: aVertex [
	"I am considered immutable."
	self shouldNotImplement
]

{ #category : #enumerating }
SCC >> do: aBlock [
	self subclassResponsibility
]

{ #category : #removing }
SCC >> remove: oldElement ifAbsent: exceptionBlock [
	"I am considered immutable."
	self shouldNotImplement
]

Class {
	#name : #KutsTest,
	#superclass : #TestCase,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
KutsTest >> testEmpty [
	| kuts |
	kuts := Kuts new.
	self assert: kuts isEmpty.
]

{ #category : #tests }
KutsTest >> testNonEmpty [
	| kuts |
	kuts := Kuts vars: #('x' 'y') asSet.
	self deny: kuts isEmpty.
]

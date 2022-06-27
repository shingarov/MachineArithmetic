Class {
	#name : #ReplaceKeyTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
ReplaceKeyTest >> testReplaceExistingKey [
	| d |
	d := Dictionary newFromAssociations: { 'a'->2. 'b'->3 }.
	d replaceKey: 'b' using: [ :x | x*x ].
	self assert: (d at: 'a') equals: 2.
	self assert: (d at: 'b') equals: 9.
]

{ #category : #tests }
ReplaceKeyTest >> testReplaceMissingKey [
	| d |
	d := Dictionary newFromAssociations: { 'a'->2. 'b'->3 }.
	d replaceKey: 'b' using: #isNil.
	d replaceKey: 'c' using: #isNil.
	self assert: (d at: 'a') equals: 2.
	self assert: (d at: 'b') equals: false.
	self assert: (d at: 'c') equals: true.
]

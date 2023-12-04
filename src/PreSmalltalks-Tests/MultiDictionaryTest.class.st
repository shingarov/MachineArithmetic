Class {
	#name : #MultiDictionaryTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
MultiDictionaryTest >> testGroupAssociations [
	"This will be replaced by proper MultiDictionary."
	| associations dict |
	associations := { 'a'->1.  'a'->2.  'b'->3. }.
	dict := associations groupAssociations .
	self assert: (dict at: 'a') equals: #(1 2) asSet.
	self assert: (dict at: 'b') equals: #(3)   asSet.

]

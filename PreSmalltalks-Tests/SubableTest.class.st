Class {
	#name : #SubableTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #'tests - 3 nils' }
SubableTest >> test3NilsSubst [
	self assert: ({nil.nil.nil} subst: #meaninglessSubst) equals: {nil.nil.nil}
]

{ #category : #'tests - 3 nils' }
SubableTest >> test3NilsSubsta [
	self assert: ({nil.nil.nil} subst: #meaninglessSubsta) equals: {nil.nil.nil}
]

{ #category : #'tests - 3 nils' }
SubableTest >> test3NilsSubstf [
	self assert: ({nil.nil.nil} subst: #meaninglessSubstf) equals: {nil.nil.nil}
]

{ #category : #'tests - 3 nils' }
SubableTest >> test3NilsSyms [
	self assert: {nil.nil.nil} syms isEmpty
]

{ #category : #'tests - collection' }
SubableTest >> testEmptyCollectionSubst [
	self assert: (#() subst: #meaninglessSubst) isEmpty
]

{ #category : #'tests - collection' }
SubableTest >> testEmptyCollectionSubsta [
	self assert: (#() substa: #meaninglessSubst) isEmpty
]

{ #category : #'tests - collection' }
SubableTest >> testEmptyCollectionSubstf [
	self assert: (#() substf: #meaninglessSubst) isEmpty
]

{ #category : #'tests - collection' }
SubableTest >> testEmptyCollectionSyms [
	self assert: #() syms isEmpty
]

{ #category : #'tests - string' }
SubableTest >> testStringSubsta [
	self assert: ('a plan' substa: #asCamelCase) equals: 'APlan'
]

{ #category : #'tests - string' }
SubableTest >> testStringSubstf [
	self assert: ('a' substf: [:_|nil]) equals: 'a'
]

{ #category : #'tests - string' }
SubableTest >> testStringSyms [
	self assert: ('a' syms includes: 'a')
]

{ #category : #'tests - string' }
SubableTest >> testStringsSubsta [
	self assert: ({'big pig' . 'can dig'} substa: #asCamelCase) equals: {'BigPig' . 'CanDig'}
]

{ #category : #'tests - nil' }
SubableTest >> testTerminalSubst [
	self assert: (nil subst: #meaninglessSubst) isNil
]

{ #category : #'tests - nil' }
SubableTest >> testTerminalSubsta [
	self assert: (nil substa: #meaninglessSubst) isNil
]

{ #category : #'tests - nil' }
SubableTest >> testTerminalSubstf [
	self assert: (nil substf: #meaninglessSubst) isNil
]

{ #category : #'tests - nil' }
SubableTest >> testTerminalSyms [
	self assert: nil syms isEmpty
]

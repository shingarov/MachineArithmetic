Class {
	#name : #VersionControlTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
VersionControlTest >> testRepoDirectory [
	| aFileReference |
	aFileReference := VersionControlTest definingGitDirectory.
	self assert: aFileReference isDirectory.
	self assert: aFileReference exists.
]

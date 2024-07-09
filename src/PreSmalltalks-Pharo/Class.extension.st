Extension { #name : #Class }

{ #category : #'*PreSmalltalks-Pharo' }
Class >> definingGitDirectory [
	^IceRepository gitDirectoryDefiningClass: self
]

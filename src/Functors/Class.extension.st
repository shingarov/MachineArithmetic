Extension { #name : #Class }

{ #category : #'*Functors' }
Class >> changeSuperclassTo: newSuperclass [
	| oldSuperclass |
	oldSuperclass := self superclass.
	self basicSuperclass: newSuperclass.
	oldSuperclass removeSubclass: self.
	newSuperclass addSubclass: self.

]

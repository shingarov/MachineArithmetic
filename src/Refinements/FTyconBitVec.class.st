Class {
	#name : #FTyconBitVec,
	#superclass : #FTycon,
	#category : #Refinements
}

{ #category : #names }
FTyconBitVec class >> conName [
	^'BitVec'
]

{ #category : #'as yet unclassified' }
FTyconBitVec >> smtApply: ts originalFApp: _ in: γ [
	| xlen |
	self assert: ts size = 1. "(BitVec SizeXX) must have exactly one SizeXX argument"
	xlen := ts first typeConstructor length.
	^Z3Sort bv: xlen
]

Class {
	#name : #FTyconUnknownBitVecSize,
	#superclass : #FTyconBitVecSize,
	#category : #Refinements
}

{ #category : #'instance creation' }
FTyconUnknownBitVecSize class >> new [
	^super length: BvLengthInference current freshSizeConstant
]

{ #category : #'bit-vectors' }
FTyconUnknownBitVecSize >> resolveIn: aDictionary [
	| resolvedLength |
	resolvedLength := aDictionary at: length functorName.
	^FTyconBitVecSize length: resolvedLength asInteger
]

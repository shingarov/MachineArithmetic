"
I represent a hole in a context, in a term-rewriting sense.
For the theoretical background, see e.g. ""Term Rewriting Systems"" by Terese (vol. 55 of ""Cambridge Tracts in Theoretical Computer Science"").
"
Class {
	#name : #Hole,
	#superclass : #Object,
	#category : #PreSmalltalks
}

{ #category : #testing }
Hole >> isHole [
	^true
]

{ #category : #printing }
Hole >> printOn: aStream [
	aStream nextPut: $_
]

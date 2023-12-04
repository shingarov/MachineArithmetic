"
Information about size of formula corresponding to an ""eliminated"" KVar.
Cf. Solution.hs
"
Class {
	#name : #KInfo,
	#superclass : #Object,
	#instVars : [
		'tags',
		'depth',
		'cubes'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
KInfo class >> new [
	^self tags: #() depth: 0 cubes: 1
]

{ #category : #'instance creation' }
KInfo class >> tags: t depth: d cubes: c [
	^self basicNew tags: t; depth: d; cubes: c; yourself
]

{ #category : #monoid }
KInfo >> + anotherKInfo [
self shouldBeImplemented 
]

{ #category : #monoid }
KInfo >> , anotherKInfo [
	| ts d s |
	ts := #(). "no tags fpr now"
	d := depth max: anotherKInfo depth.
	s := cubes * anotherKInfo cubes.
	^KInfo tags: ts depth: d cubes: s
]

{ #category : #accessing }
KInfo >> cubes [
	^ cubes
]

{ #category : #accessing }
KInfo >> cubes: anObject [
	cubes := anObject
]

{ #category : #accessing }
KInfo >> depth [
	^ depth
]

{ #category : #accessing }
KInfo >> depth: anObject [
	depth := anObject
]

{ #category : #monoid }
KInfo >> mconcatPlus: kInfos [
self shouldBeImplemented 
]

{ #category : #accessing }
KInfo >> tags [
	^ tags
]

{ #category : #accessing }
KInfo >> tags: anObject [
	tags := anObject
]

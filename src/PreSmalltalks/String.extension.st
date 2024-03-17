Extension { #name : #String }

{ #category : #'*PreSmalltalks' }
String >> compareTo: rhs [
	self = rhs ifTrue: [ ^0 ].
	^self < rhs ifTrue: [ -1 ] ifFalse: [ 1 ]
]

{ #category : #'*PreSmalltalks' }
String >> lineIntervals [
	| answer |
	answer := OrderedCollection new.
	self lineIndicesDo: [ :start :end :endLF |
		answer add: (start to: endLF) ].
	^answer
]

{ #category : #'*PreSmalltalks' }
String >> startsWithLatinLetter [
	"Answer whether the receiver's first character represents a Latin letter"
	"'Seneca' startsWithLatinLetter >>> true"
	"'Σωκράτης' startsWithLatinLetter >>> false"
	self isEmpty ifTrue: [ ^false ].
	
	^($a to: $z), ($A to: $Z) includes: self first
]

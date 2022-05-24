Extension { #name : #String }

{ #category : #'*PreSmalltalks' }
String >> startsWithLatinLetter [
	"Answer whether the receiver's first character represents a Latin letter"
	"'Seneca' startsWithLatinLetter >>> true"
	"'Σωκράτης' startsWithLatinLetter >>> false"
	self isEmpty ifTrue: [ ^false ].
	
	^($a to: $z), ($A to: $Z) includes: self first
]

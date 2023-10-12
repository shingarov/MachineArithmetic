Extension { #name : #String }

{ #category : #'*PreSmalltalks-Pharo' }
String >> isValidGlobalName [

	self ifEmpty: [ ^ false ].
	
	"reserverd default names"
	self = 'NameOfSubclass' ifTrue: [ ^ false ].
	self = 'TNameOfTrait' ifTrue: [ ^ false ].
	
	^ self first isLetter
				and: [ self allSatisfy: [:character | 
						character isAlphaNumeric or: [ character = $_ ]]]
]

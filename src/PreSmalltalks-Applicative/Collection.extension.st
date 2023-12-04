Extension { #name : #Collection }

{ #category : #'*PreSmalltalks-Applicative' }
Collection >> <*> a [
	"Cf. McBride-Paterson, 'Applicative programming with effects':
	 https://www.staff.city.ac.uk/~ross/papers/Applicative.pdf"
	^self collectAndCat: [ :f | a collect: f ]
]

{ #category : #'*PreSmalltalks-Applicative' }
Collection class >> pure [
	^[ :x | self with: x ]
]

Extension { #name : #Behavior }

{ #category : #'*PreSmalltalks' }
Behavior >> findContextReceivingMe [
	^thisContext findContextSuchThat: [ :c | c receiver isKindOf: self ]
]

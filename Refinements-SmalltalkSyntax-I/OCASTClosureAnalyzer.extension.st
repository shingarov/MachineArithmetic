Extension { #name : #OCASTClosureAnalyzer }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTClosureAnalyzer >> visitSortedArgumentNode: aSortedArgumentNode [
	aSortedArgumentNode reft notNil ifTrue: [ 
		aSortedArgumentNode reft acceptVisitor: self.
	].
	^super visitSortedArgumentNode: aSortedArgumentNode
	
	
]

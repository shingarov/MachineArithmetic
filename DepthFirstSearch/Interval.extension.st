Extension { #name : #Interval }

{ #category : #'*DepthFirstSearch' }
Interval >> graphWithEdges: es [ 
	^Graph basicNew initializeShapeFromAssocs: es within: self
]

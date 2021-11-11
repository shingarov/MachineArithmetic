Class {
	#name : #HOpt,
	#superclass : #HThing,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
HOpt class >> eliminate: what [ 
	^ HOptEliminate new 
		what: what;
		yourself
]

{ #category : #'instance creation' }
HOpt class >> fuel: n [
	^ HOptFuel new 
		n: n asInteger;
		yourself
]

{ #category : #'instance creation' }
HOpt class >> rewrite [
	^ HOptRewrite new
]

{ #category : #'instance creation' }
HOpt class >> save [
	^ HOptSave new
]

{ #category : #'as yet unclassified' }
HOpt >> addToQuery: aNNFQuery [ 
	self subclassResponsibility
]

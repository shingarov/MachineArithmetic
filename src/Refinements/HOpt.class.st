"
Cf. 'data Config' in Types/Config.hs
"
Class {
	#name : #HOpt,
	#superclass : #HThing,
	#category : #Refinements
}

{ #category : #'instance creation' }
HOpt class >> eliminate: what [
	^ HOptEliminate eliminate: what
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

{ #category : #construction }
HOpt >> addToOptions: aQueryOptions [
	self subclassResponsibility
]

{ #category : #construction }
HOpt >> addToQuery: aNNFQuery [ 
	self addToOptions: aNNFQuery options
]

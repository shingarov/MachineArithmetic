Extension { #name : #Array }

{ #category : #'*Collections-Homogeneous' }
Array class >> of: elementSpecies [ 
	| mc c |	
	mc := HomogeneousArray class copy.
	c := mc new
		superclass: HomogeneousArray superclass
		methodDictionary: HomogeneousArray methodDictionary
		format: HomogeneousArray format;
		setName: 'Array of: ', elementSpecies nameForHomoArray;
		instVarNamed: #elementSpecies put: elementSpecies;
		yourself.
	^c
]

Extension { #name : #PPXmlElement }

{ #category : #'*MachineArithmetic-Coq' }
PPXmlElement >> asCoqGoal [
	^CoqGoal fromXml: self
]

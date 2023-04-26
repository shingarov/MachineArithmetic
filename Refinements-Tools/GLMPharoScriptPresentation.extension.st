Extension { #name : #GLMPharoScriptPresentation }

{ #category : #'*Refinements-Tools' }
GLMPharoScriptPresentation >> smt2Actions [

	^ {self smt2decodeAction}
]

{ #category : #'*Refinements-Tools' }
GLMPharoScriptPresentation >> smt2decodeAction [
	^ GLMGenericAction new
				title: 'Decode escaped codepoints';
				action: [ :t :entity |
					entity content: (Smt2CodepointsReadStream on: entity content) contents. t update ]; 
				yourself.
]

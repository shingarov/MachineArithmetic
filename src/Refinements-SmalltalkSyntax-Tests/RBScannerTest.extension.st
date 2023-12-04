Extension { #name : #RBScannerTest }

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBScannerTest >> testScanQuantifierToken [
	| source scanner token |	
	source := String with: Character forall.
	scanner := self buildScannerForText: source.
	token := scanner next.
	self assert: token isSpecial.
	self assert: token startsBlockArg.
	self deny: token isError.
	self assert: token value equals: Character forall.
]

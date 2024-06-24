Extension { #name : #RBMessageNode }

{ #category : #'*MathNotation-Pharo' }
RBMessageNode class >> receiver: aValueNode selector: aSelector keywordsPositions: positionList arguments: valueNodes [
	^(self new)
		receiver: aValueNode
			selector: aSelector
			keywordsPositions: positionList 
			arguments: valueNodes;
		wrapSectionedSend
]

{ #category : #'*MathNotation-Pharo' }
RBMessageNode >> wrapSectionedSend [
	| allArgs holes block blockArgs |
	allArgs := {receiver}, arguments.
	(allArgs noneSatisfy: #isSectionArgument) ifTrue: [
		^self  "ordinary MessageNode"
	].

	"sectioned message send"
	holes := allArgs select: #isSectionArgument.
	blockArgs := holes collect: #holePlug.

	receiver := receiver holePlug.
	receiver parent: self.
	arguments := arguments collect: #holePlug.
	arguments do: [ :eachArgument | eachArgument parent: self ].

	block := RBBlockNode
		arguments: blockArgs
		body: (RBSequenceNode statements: (OrderedCollection with: self)).
	blockArgs do: [ :eachBlockArg | eachBlockArg parent: block ].
	^block
]

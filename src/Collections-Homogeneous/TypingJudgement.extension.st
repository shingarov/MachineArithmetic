Extension { #name : #TypingJudgement }

{ #category : #'*Collections-Homogeneous' }
TypingJudgement >> asSlot [
	term isString ifFalse:[
		self error:'term must be a string or symbol'.
		^nil.
	].
	^TypedSlot named: term asSymbol type: type
]

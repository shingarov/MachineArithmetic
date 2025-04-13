Extension { #name : #FTC }

{ #category : #'*SpriteLang' }
FTC >> sort2bTrue [
	typeConstructor isBitVecSizeTC ifFalse: [ self error ].
	^TBvSize basicNew
		ftycon: typeConstructor;
		ts: {};
		ars: {};
		r: Reft trueReft known;
		yourself 
]

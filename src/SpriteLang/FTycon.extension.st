Extension { #name : #FTycon }

{ #category : #'*SpriteLang' }
FTycon class >> newTCon: c ts: ts ars: ars r: r [
	| ft |
	ft := self symbolFTycon: c.
	^TBvSize basicNew
		ftycon: ft;
		ts: ts;
		ars: ars;
		r: r;
		yourself 
]

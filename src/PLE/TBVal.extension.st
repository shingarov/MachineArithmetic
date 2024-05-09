Extension { #name : #TBVal }

{ #category : #'*PLE' }
TBVal >> loopB: env ctx: ctx delta: Δ maybeBindId: i res: res [
	^env
		withAssms: ctx
		delta: Δ
		maybeSubcId: a
		act: [ :ctx′ | (env ple1: ctx′ mbBindId: i res: res) value ]
]

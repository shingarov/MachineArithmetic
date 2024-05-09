Extension { #name : #TBBind }

{ #category : #'*PLE' }
TBBind >> loopB: env ctx: ctx delta: Δ maybeBindId: iMb res: res [
	^trie loopT: env ctx: ctx delta: {key},Δ maybeBindId: key res: res
]

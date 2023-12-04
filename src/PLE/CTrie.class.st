Class {
	#name : #CTrie,
	#superclass : #Trie,
	#category : #PLE
}

{ #category : #'instance creation' }
CTrie class >> mkCTrie: ics [
"
-- | Step 1b: @mkCTrie@ builds the @Trie@ of constraints indexed by their environments
--
-- The trie is a way to unfold the equalities a minimum number of times.
-- Say you have
--
-- > 1: [1, 2, 3, 4, 5] => p1
-- > 2: [1, 2, 3, 6, 7] => p2
--
-- Then you build the tree
--
-- >  1 -> 2 -> 3 -> 4 -> 5 — [Constraint 1]
-- >            | -> 6 -> 7 — [Constraint 2]
--
-- which you use to unfold everything in 1, 2, and 3 once (instead of twice)
-- and with the proper existing environment

mkCTrie :: [(SubcId, SimpC a)] -> CTrie
                  ics
"
	^self fromList: (ics collectAssociations: [ :i :c | c senv elemsIBindEnv sorted -> i ])
]

{ #category : #'as yet unclassified' }
CTrie >> loopT: env ctx: ctx delta: Δ maybeBindId: i res: res [

self shouldBeImplemented.

	branches isEmpty  ifTrue: [ ^res ].  "case Node[]"
	branches size = 1 ifTrue: [          "case Node[b]"
			| b |
			b := branches first.
			^b loopB: env ctx: ctx delta: Δ maybeBindId: i res: res  ].
	




	^InstRes newFromAssociations: { 
		1 -> (
		(('adder' functionFrom: { Int sort . Int sort } to: Int sort)
			value: 'x' toInt value: 'yºº1' toInt) === 11 )
	 }
	
]

{ #category : #'as yet unclassified' }
CTrie >> pleTrie: env [
"
Step 2: Walk over the CTrie to actually do the incremental-PLE
pleTrie :: CTrie -> InstEnv a -> IO InstRes
            t        env
"
	| es₀ es₀′ ctx₀ |
	es₀ := env ieAenv aenvEqs select: [ :eachEq | eachEq eqArgs isEmpty ].
	es₀′ := #()."BOGUS"
	ctx₀ := env initCtx: #(). "BOGUS, but that's what it happens to be in testPLE0"
	^self loopT: env ctx: ctx₀ delta: #() maybeBindId: nil res: InstRes new
]

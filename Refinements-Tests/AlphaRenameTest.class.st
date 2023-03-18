Class {
	#name : #AlphaRenameTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #'tests-renaming' }
AlphaRenameTest >> testRenameAnd [
	| q c renamed |
	q := NNFParser parse: '(constraint
	  (forall ((x Int) (x > 0))
	    (and ((x+1 < 100)) ((a > b)))))'.
	c := q qCstr first.
	renamed := c rename: 'x' to: 'y'.
	self assert: renamed bind x equals: 'y'
]

{ #category : #'tests-renaming' }
AlphaRenameTest >> testRenameBoundVar [
	| q c renamed substs subst |
	q := NNFParser parse: '(constraint
	  (forall ((x Int) (x > 0))
	    ((x+1 < 100))))'.
	c := q qCstr first.
	renamed := c rename: 'x' to: 'y'.
	self assert: renamed bind x equals: 'y'.
	substs := renamed bind p substitutions.
	self assert: substs size equals: 1.
	subst := substs list first.
	self assert: subst key equals: 'x'.
	self assert: subst value equals: (EVar of: 'y').
]

{ #category : #'tests-renaming' }
AlphaRenameTest >> testRenameTrivial [
	| q c renamed |
	q := NNFParser parse: '(constraint
	  (forall ((x Int) (x > 0))
	    ((x+1 < 100))))'.
	c := q qCstr first.
	renamed := c rename: 'a' to: 'b'.
	"We CAN'T say c=renamed, because we don't know the internal structure of DecidableRefinement.
	I.e., the best we can do is a DelayedSubst which will collapse in the end."
	self assert: c bind x equals: renamed bind x.
	self assert: c bind τ equals: renamed bind τ.
	
]

{ #category : #'tests-uniqifying' }
AlphaRenameTest >> testUniqifyNested [
	| q cstr uniqified |
	q := NNFParser parse: '(constraint
	  (forall ((x Int) (x > 0))
	    (forall ((x Int) (x > 10))
	      ((x > 5)))))'.
	cstr := q qCstr first.
	uniqified := cstr uniq.
	self assert: uniqified bind x equals: 'x'.
	self assert: uniqified p bind x equals: 'xº1'.
	self assert: uniqified p bind p substitutions list first equals: 'x'->(EVar symbol: 'xº1').
	self assert: uniqified p bind x equals: 'xº1'.
]

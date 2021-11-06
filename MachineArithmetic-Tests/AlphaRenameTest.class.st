Class {
	#name : #AlphaRenameTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Fixpoint'
}

{ #category : #tests }
AlphaRenameTest >> testRenameAnd [
	| q c renamed |
	q := NNFParser parse: '(constraint
	  (forall ((x Int) (x > 0))
	    (and ((x+1 < 100)) ((a > b)))))'.
	c := q qCstr first.
	renamed := c rename: 'x' to: 'y' renamer: AlphaRenamer new.
	self assert: renamed bind x equals: 'y'
]

{ #category : #tests }
AlphaRenameTest >> testRenameBoundVar [
	| q c renamed |
	q := NNFParser parse: '(constraint
	  (forall ((x Int) (x > 0))
	    ((x+1 < 100))))'.
	c := q qCstr first.
	renamed := c rename: 'x' to: 'y' renamer: AlphaRenamer new.
	self assert: renamed bind x equals: 'y'.
	self assert: renamed bind p substitutions equals: (Dictionary newFromAssociations: {'x'->'y'.})
	
]

{ #category : #tests }
AlphaRenameTest >> testRenameTrivial [
	| q c renamed |
	q := NNFParser parse: '(constraint
	  (forall ((x Int) (x > 0))
	    ((x+1 < 100))))'.
	c := q qCstr first.
	renamed := c rename: 'a' to: 'b' renamer: AlphaRenamer new.
	"We CAN'T say c=renamed, because we don't know the internal structure of DecidableRefinement.
	I.e., the best we can do is a DelayedSubst which will collapse in the end."
	self assert: c bind x equals: renamed bind x.
	self assert: c bind τ equals: renamed bind τ.
	
]

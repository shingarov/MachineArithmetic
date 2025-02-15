"
Notes on unification of sorts in the presence of Smalltalk late binding

(Someone please find a more logical place for these notes)

In upstream Liquid Fixpoint, (and in Haskell and in Z3 which are LF's basis),
parametrized types are instantiated and unification finds the most general
unified type; all this at compile type.  LF adds a hierarchy of topos-theoretic
subobjects to this basic structure of (Z3) sorts.  In these notes we shall
concentrate on sorts, deferring refinements to future ""Liquid Smalltalk"" work.

In Smalltalk, the sort of a symbol such as #+ is not statically known: an
expression like

  a + b

could SMT-serialize to

  (bvadd a b)

in one place where a and b are BitVectors, and to

  (+ a b)

in another place where a and b are Ints.  This creates a problem when
sort-checking a Decidable Refinement.  In LF, formulae are decidable first-
order molecular predicates comprising logical connectives over PAtoms.
An atom may be a relation over terms.  A term may comprise operators acting
on other terms.

We don't know a priori which selectors refer to logical connectives and which
to operators, e.g. #& is 𝔹->𝔹->𝔹, but also ℤ->ℤ->ℤ (alias for #bitAnd:).

Normally in algebra, an ""operator"" is by definition closed, e.g. group
multiplication, or ring addition and multiplication, do not take us outside
the group/ring:

  #* :: 'a -> 'a -> 'a
  #+ :: 'a -> 'a -> 'a

Unfortunately, in our world we also have to deal with selectors such as #,
(for BitVector concatenation).  From the viewpoint of Sorts, this is not
a closed operator, and its signature cannot be expressed in simple
Hindley–Milner algebra: from a Hindley–Milner standpoint,

  #, :: BV(i) -> BV(j) -> BV(k)

and all we can say about k is that BV(k) unifies with its use; but what
about the constraint k=i+j?

Existing upstream work gives us no guidance here.  Consider the following
variation on tests/pos/bitvec-ii.fq:

bind 0 x : {v : (BitVec Size4) | v = (lit ""#b1000"" (BitVec Size4))}
bind 1 y : {v : (BitVec Size9) | v = (app (_ repeat 2) x)}
bind 2 z : {v : (BitVec Size9) | v = (lit ""#b010001000"" (BitVec Size9))}
constraint:
  env [0;1;2]
  lhs {v : (BitVec Size9) | [ v = y ] }
  rhs {v : (BitVec Size9) | [ v = z ] }
  id 1 tag []

Liquid Fixpoint will happily unify ""y"" with ""repeat 2 x"", unsuspecting
until crash in Z3 at the final Sat check:

Crash!: :1:1-1:1: Error
  crash: SMTLIB2 respSat = Error ""line 3 column 9645: Sorts (_ BitVec 9) and (_ BitVec 8) are incompatible""
CRASH: -1

There is simply no notion allowing us to reason about the dependency
between repeat's input and output sorts.

We solve this problem by introducing constraints between sorts.
Each constraint is a Z3 formula.  The present class, BvLengthInference,
represents the state of an ongoing elaboration with respect to these
constraints.  We start from empty collection of constraints.  When for
example repeat's fuction sort is elaborated (for a particular call),
a Z3 Bool to the effect of ""times*inLength===outLength"" is added
to the collection.  At the end of #elaborate, the AND of the formulae
is checked for satisfiability.  Exactly one model should exist.  Unsat
means the sorts are Incompatible; more than one means Underconstrained.
"
Class {
	#name : #BvLengthInference,
	#superclass : #Object,
	#instVars : [
		'constraints',
		'j'
	],
	#category : #Refinements
}

{ #category : #accessing }
BvLengthInference class >> current [
	^Context readState: #bvLengthInference
]

{ #category : #API }
BvLengthInference >> addConstraint: aZ3Formula [
	self constraints add: aZ3Formula
]

{ #category : #accessing }
BvLengthInference >> constraints [
	constraints isNil ifTrue: [ constraints := OrderedCollection new ].
	^ constraints
]

{ #category : #API }
BvLengthInference >> freshSizeConstant [
	j := self j + 1.
	^('ßßBitVectorSize_', j printString) toInt
]

{ #category : #accessing }
BvLengthInference >> j [
	j isNil ifTrue: [ j := 0 ].
	^ j
]

{ #category : #API }
BvLengthInference >> resolveIfUnsat: unsatBlock ifAmbiguous: ambBlock [
	| solver |
	solver := Z3Solver new.
	solver assert: (Bool and: self constraints asArray).
	[
		| model |
		solver check ifFalse: [ ^unsatBlock value ].
		model := solver getModel.
		solver blockModel.
		solver check ifTrue: [ ^ambBlock value ].
		^model constants
	] ensure: [ solver delete ]
]

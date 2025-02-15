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
"
Class {
	#name : #EMessageSend,
	#superclass : #Expr,
	#instVars : [
		'messageSend'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EMessageSend class >> of: aMessageSend [
	^self basicNew
		messageSend: aMessageSend;
		yourself
]

{ #category : #visiting }
EMessageSend >> accept: aVisitor [ 
	^self class of: (messageSend accept: aVisitor)
]

{ #category : #'sort-checking' }
EMessageSend >> checkExpr: f [
	^messageSend checkExpr: f
]

{ #category : #elaboration }
EMessageSend >> elab: anElabEnv [
	^messageSend elab: anElabEnv
]

{ #category : #elaboration }
EMessageSend >> elabApply: γ [
	^self class of: (messageSend elabApply: γ)
]

{ #category : #uncurrying }
EMessageSend >> elabApplyStep: γ [ 
	^EMessageSend of: (messageSend elabApply: γ)
]

{ #category : #'term rewriting' }
EMessageSend >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^messageSend evaluateIn: anEvalEnv ifUndeclared: vndBlock
]

{ #category : #accessing }
EMessageSend >> messageSend [
	^ messageSend
]

{ #category : #accessing }
EMessageSend >> messageSend: anObject [
	messageSend := anObject
]

{ #category : #'SMT interface' }
EMessageSend >> smt2: γ [
	^(messageSend receiver smt2: γ)
		perform: messageSend selector
		withArguments: (messageSend arguments collect: [ :arg | arg smt2: γ ])
]

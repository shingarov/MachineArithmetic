"
RBHoleToken is a lexical-level representation of a hole, i.e. an empty space
in an incomplete term.  For example, in category theory it is standard to write
𝒞(A,–) meaning 'that thing which takes B to answer 𝒞(A,B)'. In the 'sectioning'
notation (standard in BMF formalism), the function ⊕y takes x to x⊕y (here
⊕::A×B→C is an arbitrary binary operator).  In term rewriting, it is customary
to allow terms to contain occurrences of a special constant symbol □.

Although this construct can, in principle, be spelled out in coordinates,
in the above-mentioned applications this notational abstraction becomes
essential, as opposed to merely convenient.

Implementation Notes:

At the lexical level, the Hole is represented by a dedicated single character;
which character it is, is specified by RBHoleToken class>>codePoint.
The scanner isolates the rest of the parser from knowledge of this concrete
syntax.

In the present notation, the scope of an incomplete term is always the message
send.  For example, you can write

  a := 3+□

but not

  a := □

or

  ^□.

Because this notation is an extension to our substrate language, which is
Smalltalk-80, the meaning of these incomplete terms is given by BlockClosures.
For example,

  3+□

stands for

  [ :x | 3+x ]

where x is some image-unique variable name.

A message send may contain zero or more hole arguments (including self).
If there are more than one hole, each hole becomes a separate block argument;
the order of currying is

  self → arg₁ → … → argₙ.

"
Class {
	#name : #RBHoleToken,
	#superclass : #RBToken,
	#category : #'MathNotation-Pharo'
}

{ #category : #'concrete syntax' }
RBHoleToken class >> codePoint [
	"In the current implementation, we use $□ ('WHITE SQUARE', U+25A1)
	 to denote 'Hole' in concrete syntax, but any suitable character,
	 such as $– ('EN DASH' (U+2013), $☐ ('BALLOT BOX', U+2610), etc
	 should work, by changing ONLY this method."

	^16r25A1
]

{ #category : #testing }
RBHoleToken >> isHole [
	^true
]

{ #category : #accessing }
RBHoleToken >> length [
	^1
]

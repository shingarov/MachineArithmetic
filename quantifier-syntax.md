# Generalized bound variables in Smalltalk

In mathematics, "bound" (aka "dummy") variables are everywhere.
Perhaps the first example of bound variables a teenager mathematician encounters,
are integration variables: familiarizing with the idea that _∫[0:1]f(x)dx_
is the same as _∫[0:1]f(y)dy_, leading to the concept of α-equivalence.
Further the student meets with λ-terms (equivalence classes of preterms modulo α),
first-order quantifiers ∀ and ∃, higher-order Horn quantifier ⋆, and so on.

One hundred years ago, Schönfinkel and shortly after him Church, Turing and Curry,
understood the role of functions, not sets, as the most suitable primary concept
at the foundation of mathematics.
In this light it is not surprising how much of computer science —
and especially foundational fields such as theory of interpretation —
revolves around the concepts of function abstraction and function application.

Following Iverson's idea of notation as the crucial element enabling thought,
it is then of utmost importance to have appropriate notation for these two core concepts.

The basic building material of language is the alphabet:
the characters which we combine into written thought.
Regrettably, the standard alphabet from which most of our programming languages have been built,
is ASCII — an extremely limited character set.
For example, we can't write what Church wrote for functional abstraction:

```
λx. ...something...
```

Iverson solves this problem using the most radical approach in his programming language APL.
Programmers in other programming languages are less fortunate and have to resort to various contraptions.
For example, Haskell programmers substitute `\` (backward slash) for λ:

```
\x. ...something...
```

perhaps inspired by typewritten lecture notes, and perhaps in analogy with those who type 'u' in place of 'μ'.

In Smalltalk, we write

```
[ :x | ...something... ]
```

for λ-abstraction.

When the compiler encounters this syntax,
it emits code that at runtime will create the corresponding `BlockClosure`.
This has worked well for several decades, and this author is pretty content with this design.
What the author is NOT content with, is that this is limited to only λ-abstraction
and disallows all other kinds of quantification.
In the past two decasdes of writing mathematical logic in Smalltalk,
he was forced to express many thousands of first-order formulae

```
∀x. ...something...
```

by manually instantiating class `Forall`:

```
myFormula := Forall new
    varName: #x;
    predicate: (...code for evaluating something...);
    yourself.
```

This feels conceptually as bad as forcing the programmer to notate a block by manually instantiating `BlockClosure`:

```
myBlock := BlockClosure new
    literals: #(...);
    bytecodes: (...code to emit the bytecode...);
    ...
```

Something needed to be done about it.

The first idea — to add more syntax to Smalltalk — appeared like an immediate no-go.
To inverse-vandalize Smalltalk's simple LL(1) syntax which fits on a postcard,
by increasing its complexity, seems contradictory to core values of Smalltalk.
The author's preferred aim would be to *decrease* the number of lines-of-code in the Compiler by solving a *more general* problem.

The insight is that the syntactic _shape_ of `[ :x |...]` says nothing about the _kind_ of the binding —
only that _x_ is a bound variable.
That information about the _kind_ is encapsulated inside the `:` token.
So, change (1) is: we remove the knowledge about `:` hard-coded in the Scanner,
and replace it with a user-defined Dictionary which maps `:`, `∀` etc
to classes containing _kind_-specific behavior.
Change (2) is: we remove all _kind_-specific behavior out of the Parser and the backend
(for example, the knowlegde how to create a BlockClosure)
and replace it with a reference to the value in that Dictionary.
In practice, it is even possible to vary local shape per kind,
without escaping out of the kind-specific user-defined class.
For example, we accept

```
[ ∀i∈ℤ [i<0] | (A at: i) > 10 ]
```

which intuitively reads "for all negative whole i, `A at: i` exceeds 10".

## Examples, and usefulness in larger proofs

The author has built an experimental implementation of the above proposal,
and replaced a number of manually-instantiated propositions in his research on extensions of Floyd-Hoare logic by formulae in the new syntax.
Here are two examples:

1. First-order formulae in decidable theories.
Sending `#proveValid` to the block

```
[ ∀x ∈ ℤ [x>=0] | [ ∀y ∈ ℤ [y>x] | y > 0 ] ]
```

answers `#Safe`.
On the other hand, sending `#proveValid` to the block

```
[ ∀x ∈ ℤ [x>=0] | [ ∀y ∈ ℤ [y>=x] | y > 0 ] ]
```

raises a `NotValid` exception.
The fun point about this example is nested blocks: the precondition in the inner block captures the variable _x_ which is the dummy quantification variable of the outer block.

2. Our second characteristic example comes from the well-known problem of automatic inference of weakest preconditions from intermittent assertions.
Consider the following program in a fictionary toy language:

```
⟦ val assert : Bool[b|b] → void ⟧
let assert = (b) => {
  nil "just because the function has to have *some* range;
       the remarkable thing about assert is that nothing magical is attached to it:
       the contract above is the whole implementation"
};

⟦ val abs : x:ℤ→ℤ[?] ⟧
let abs = (x) => {
  let pos = x ≥ 0;
  if (pos) {
    x
  } else {
    0 - x
  }
};

⟦ val main : ℤ→void ⟧
let main = (y) => {
  let ya  = abs(y);
  assert(ya≥0)
};
```

This example illustrates Cousot's algorithm for enabling the use of `#assert:`s instead of Floyd-Hoare contracts.
Here, static analysis is trying to prove that `abs` always behaves correctly provided
it's called with an argument satisfying `abs`'s preconditions,
and that `main` behaves correctly provided `abs` adheres to `abs`'s contract.
In classical Floyd-Hoare logic the programmer would have to supply `abs`'s contract by hand:

```
⟦ val abs : x:ℤ→ℤ[:v|v≥0] ⟧
```

With this contract explicitly given, correctness of both `abs` and `main`
is reduced (by a standard algorithm known as "bidirectional checking")
to a formula similar to that in our Example 1 which Z3 easily checks to be valid.

Unfortunately, supplying contracts by hand does not scale to programs of any realistic size.
On the other hand, many programs we are interested in, already contain abundant `#assert:`s interspersed in methods' bodies.
Algorithms to infer contracts from such `#assert:`s are widely known in the compiler community.
One approach is to regard the unknown contract as a Horn variable (conventionally written κ)
which — on the post-condition side — is strong enough to guarantee the `ya≥0` actual parameter to the `assert` can never be false
(and in general, the dual on the pre-condition side but in this case `abs` doesn't have anything interesting there).
So the Horn solver's job is to find an assignment for the predicate
```
κ : ℤ×ℤ→ℬ
```

which will satisfy the first-order formula synthesized by bidirectional checking:

```
∀x,c,v. (c ⇔ x≥0) ⇒ c ⇒ v=x ⇒ κ(x,v)
∧  ¬c ⇒ v=-x ⇒ κ(x,v)
∧  ∀y,z,c,b. κ(y,z) ⇒ (c ⇔ z≥0) ⇒ (b⇔c) ⇒ b
```

What is the meaning of κ here?  It serves as a _template_ for the yet-unknown post-condition of `abs`:

```
⟦ val abs : x:ℤ→ℤ[:v|κ(x,v)] ⟧
```

Note that we can't write "∃κ" because κ is a predicate, not an individual;
and Z3 cannot solve the problem of finding an assignment for κ.
MachineArithmetic implements a Horn solver in Smalltalk; the present proposal wraps the solver in block syntax:

```
[ ⋆κ | [ ∀x∈ℤ, ... ] ].
```

This compiles to code that instantiates a `HornQuery`.
Objects of class `HornQuery` respond to `#solve`; the query above will answer a Dictionary with #κ→[ :x :v | v≥0 ], for the found assignment:

```
κ(x,v) = (v≥0).
```

What happens if the program is in fact incorrect?
Here, we understand "incorrect" in the sense that whatever contract we assign to the callee,
either the callee's body or `main` will violate it, or some execution path will cause
an assert failure
(which is of the same nature because it simply means violating `#assert:`'s contract at the call site).
The toy compiler will compile this into some `[ ⋆κ | ... ]` for which no satisfying κ exist; sending `#solve` to it will raise a `SafetyException`.


## Code Artifacts

live in `Refinements-SmalltalkSyntax-*`.

## Micro-bibliography

* [Cousot.  Principles of Abstract Interpretation.  MIT, 2021](https://mitpress.mit.edu/9780262044905/principles-of-abstract-interpretation)
* [Cosman, Jhala.  Local Refinement Typing](https://dl.acm.org/doi/10.1145/3110270)
* [Cousot et al.  Precondition Inference from Intermittent Assertions and Application to Contracts on Collections](https://www.di.ens.fr/~cousot/publications.www/CousotCousotLogozzo-VMCAI-LNCS-6538-pp150--168-Jan-2011.pdf)
* [Shingarov.  Colon stands for lambda: Generalized bound variables in Smalltalk](https://www.youtube.com/watch?v=r8RwJje0sOA)

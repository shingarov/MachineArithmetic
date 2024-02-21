"
This test gives an example of a Galois connection — a pair of functions
which are ""almost inverse"" to each other in an amazing way.

One possible representation of Booleans in the computer, would be as an
isomorphism 𝔹≅{0,1}: ""0 for false, 1 for true"".
In this case we have a pair of functions, b2i and i2b:

  b2i :: 𝔹 → {0,1}
  b2i(false) = 0
  b2i(true)  = 1

  i2b :: {0,1} → 𝔹
  i2b(0) = false
  i2b(1) = true

These are inverses of each other:

  i2b ∘ b2i = Id(𝔹)
  b2i ∘ i2b = Id({0,1})

In Kernighan and Ritchie's ""C"" language, booleans are represented in an
almost, but not quite the same way:

  if (c) {
    ...trueBranch...
  } else {
    ...falseBranch...
  }

takes the trueBranch when c is any nonzero int, and falseBranch if c==0.

Let's ignore the difference between int and ℤ for simplicity, and try to
construct b2i and i2b similar to above:

  b2i :: 𝔹 → ℤ
  b2i(false) = 0
  b2i(true)  = 1

  i2b :: ℤ → 𝔹
  i2b(0) = false
  i2b(i) = true ∀i≠0

These are no longer inverse: although

  i2b ∘ b2i = Id(𝔹),

it breaks in the other direction:

  b2i ∘ i2b ≠ Id(ℤ)

because i2b is not injective: it ""loses information"" by ""squishing"" all
nonzero ints together into one point:

  b2i(i2b(42)) = 1 ≠ 42.

This is a Galois connection.  𝔹 is a ""blurry image"" of ℤ: looking through
the i2b lens, we can resolve 0 from 1 but we can't resolve 1 from 42.

If we order 𝔹 as usual:

  false ≤ true

and ℤ as

  0 ⊑ i ∀i∈ℤ,
  1 ≡ 2 ≡ 3 ≡ ...,

then i2b is the left (aka lower) adjoint and b2i is the right (upper) adjoint:

  i2b(i) ≤ b  iff  i ⊑ b2i(b)

(In the terminology of Abstract Interpretation, i2b is the ""abstractor""
and b2i is the ""concretizer"").

           b2i
  true ---------→ 1≡2≡3≡...
    ↑              |
   ≤|              |⊑
    |      i2b     ↓
  false ←--------  0

"
Class {
	#name : #BoolGaloisConnectionTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
BoolGaloisConnectionTest >> testAlphaClash [
	"This test is identical to testIidI, except w is renamed to i,
	 so must end up in the same UNSAFE result.
	 However, this breaks, see issue #139.
	"
	self skip. "Remove this skip after #139 is resolved."
	self proveUnsafe: '
⟦val b2i : b:bool => int[i | ((i===0) not <=> b) & ((i===0)|(i===1)) ] ⟧
let b2i = (b) => {
  if (b) { 1 } else { 0 }
};

⟦val i2b : i:int => bool[b | (i===0) not <=> b ] ⟧
let i2b = (i) => {
  let notZero = i != 0;
  if (notZero) { true } else { false }
};

⟦val i2i : x:int => int[y | y === x ] ⟧
let i2i = (i) => {
  let b = i2b(i);
  b2i(b)
};
'
]

{ #category : #tests }
BoolGaloisConnectionTest >> testAlphaClash2 [
	self proveSafe: '
⟦val f1 : x:int => y:int => int[z | z === (x + y + 3) ] ⟧
let f1 = (x,y) => {
	let x = x + 1;
	let y = y + x;	
	y + 2
};
'
]

{ #category : #tests }
BoolGaloisConnectionTest >> testB2I [
	self proveSafe: '
⟦val b2i : b:bool => int[i | (i===0) not <=> b ] ⟧
let b2i = (b) => {
  if (b) {
    1
  } else {
    0
  }
};
'
]

{ #category : #tests }
BoolGaloisConnectionTest >> testBidB [
	self proveSafe: '
⟦val b2i : b:bool => int[i | (i===0) not <=> b ] ⟧
let b2i = (b) => {
  if (b) {
    1
  } else {
    0
  }
};

⟦val i2b : i:int => bool[b | (i===0) not <=> b ] ⟧
let i2b = (i) => {
  let notZero = i != 0;
  if (notZero) {
    true
  } else {
    false
  }
};

⟦val b2b : x:bool => bool[y | y === x ] ⟧
let b2b = (b) => {
  let i = b2i(b);
  i2b(i)
};
'
]

{ #category : #tests }
BoolGaloisConnectionTest >> testGalois [
	self proveSafe: '
⟦val b2i : b:bool => int[w | ((w===0) not <=> b) & ((w===0)|(w===1)) ] ⟧
let b2i = (b) => {
  if (b) { 1 } else { 0 }
};

⟦val i2b : i:int => bool[b | (i===0) not <=> b ] ⟧
let i2b = (i) => {
  let notZero = i != 0;
  if (notZero) { true } else { false }
};

⟦val leqB : b1:bool => b2:bool => bool[leq | leq <=> (b1 ==> b2) ] ⟧
let leqB = (b1, b2) => {
  b1 ==> b2
};


⟦val leqZ : k1:int => k2:int => bool[leqz | leqz <=> ( (k1===0) | (k2~==0) ) ] ⟧
let leqZ = (k1, k2) => {
  let k1isZero = k1 == 0;
  if (k1isZero) {
    true
  } else {
    k2 != 0
  }
};

⟦val galois : b:bool => i:int => bool[good|good] ⟧
let galois = (b, i) => {
  let bb = i2b(i);             let ii = b2i(b);
  let leqb = leqB(bb, b);      let leqi = leqZ(i,ii);
  leqb                    <=>  leqi
};
'
]

{ #category : #tests }
BoolGaloisConnectionTest >> testI2B [
	self proveSafe: '
⟦val i2b : i:int => bool[b | (i===0) not <=> b ] ⟧
let i2b = (i) => {
  let notZero = i != 0;
  if (notZero) {
    true
  } else {
    false
  }
};
'
]

{ #category : #tests }
BoolGaloisConnectionTest >> testIidI [
	self proveUnsafe: '
⟦val b2i : b:bool => int[w | ((w===0) not <=> b) & ((w===0)|(w===1)) ] ⟧
let b2i = (b) => {
  if (b) { 1 } else { 0 }
};

⟦val i2b : i:int => bool[b | (i===0) not <=> b ] ⟧
let i2b = (i) => {
  let notZero = i != 0;
  if (notZero) { true } else { false }
};

⟦val i2i : x:int => int[y | y === x ] ⟧
let i2i = (i) => {
  let b = i2b(i);
  b2i(b)
};
'
]

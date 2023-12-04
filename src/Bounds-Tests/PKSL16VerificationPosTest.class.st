"
Verification of examples from Polikarpova–Kuraj–Solar-Lezama's PLDI'16 paper,
""Program Synthesis from Polymorphic Refinement Types"" (their code from the Synquid
repo: https://github.com/nadia-polikarpova/synquid/tree/master/test/pldi16).

NB: We are simply *checking* the terms synthesized by Synquid, so it may appear
that the contracts discard most of the nontrivial information of what the program
must do.  The magic is exactly that parametricity (encoded in de Bruin's naturality)
restores everything from the projection — this is why Synquid works.  In this test,
we go in the verification, not synthesis, direction.
"
Class {
	#name : #PKSL16VerificationPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'Bounds-Tests'
}

{ #category : #'list-L₆' }
PKSL16VerificationPosTest >> test_listAppend [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;

⟦val append : xs:list(''a) => ys:list(''a) => list(''a)[v| v∘len === ((xs∘len) + (ys∘len)) ]⟧
let rec append = (xs, ys) => {
  switch (xs) {
    | Nil        => ys
    | Cons(h, t) => let rest = append(t, ys);
                    Cons(h, rest)
  }
};
'
]

{ #category : #'tree-L₆' }
PKSL16VerificationPosTest >> test_treeCount [
	self processString: '
⟦measure size : tree(''a) => int⟧

type tree(''a) =
  | Nil => [v| v∘size === 0 ]
  | Cons (x:''a, l:tree(''a), r:tree(''a)) => [v| v∘size === ( (l∘size) + (r∘size) + 1 ) ]
  ;

⟦val countNodes : t:tree(''a) => int[v| v === (t∘size) ]⟧
let rec countNodes = (t) => {
  switch (t) {
    | Nil           => 0
    | Cons(x, l, r) => let countLeft  = countNodes(l);
                       let countRight = countNodes(r);
                       let together = countLeft + countRight;
                       together + 1
  }
};
'
]

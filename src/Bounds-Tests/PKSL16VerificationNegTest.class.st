Class {
	#name : #PKSL16VerificationNegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'Bounds-Tests'
}

{ #category : #'tree-L₆' }
PKSL16VerificationNegTest >> test_treeCount [
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
                       together
  }
};
'
]

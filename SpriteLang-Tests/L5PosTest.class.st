Class {
	#name : #L5PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-safety' }
L5PosTest >> test_append00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                      => [v| len v = 0]
  | Cons (x:''a, xs:list(''a)) => [v| len v = 1 + len(xs)]
  ;

⟦val append : xs:list(''a) => ys:list(''a) => list(''a)[v|len v = len(xs) + len(ys)]⟧
let rec append = (xs, ys) => {
  switch (xs) {
    | Nil        => ys
    | Cons(h, t) => let rest = append(t, ys);
                    Cons(h, rest)
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_cons00 [
	self processString: '
⟦measure len : list(''a) => int ⟧

type list(''a) =
  | Nil                      => [v| len v = 0]
  | Cons (x:''a, xs:list(''a)) => [v| len v = 1 + len(xs)]
  ;

⟦val singleton : ''a => list(''a)[v|len v = 1] ⟧
let singleton = (x) => {
  let t = Nil;
  Cons(x, t)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_foldRight00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_head00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_head01 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_isort00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_isort01 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_listSet [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_nil00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist01 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist02 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_single00 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_tail01 [
	self processString: '
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L5PosTest >> test_tuple00 [
	self processString: '
⟦ ⟧




'
]

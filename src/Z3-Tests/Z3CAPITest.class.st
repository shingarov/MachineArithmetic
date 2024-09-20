"
Tests equivalent to z3/examples/c/test_capi.c
"
Class {
	#name : #Z3CAPITest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Z3-Tests'
}

{ #category : #tests }
Z3CAPITest >> exampleArray2: n [
	"Instance of testArray2 with n arrays"
	
	| arraySort arrays distinct solver sat |

	arraySort := Z3Sort bool --> Z3Sort bool.
	arrays := (0 to: n - 1) collect: [ :i |
		| s |
		s := Z3Symbol from: i.
		Z3AST mkConst: s ofSort: arraySort ].
	
	distinct := arraySort ctx mkDistinct: arrays.
	solver := arraySort ctx mkSolver.
	solver assert: distinct.
	sat := solver check.
	solver release.
	^sat
]

{ #category : #tests }
Z3CAPITest >> testArray1 [
	"Prove
		store(a1, i1, v1) = store(a2, i2, v2) implies (i1 = i3 or i2 = i3 or select(a1, i3) = select(a2, i3)).
   This example demonstrates how to use the array theory."
	| s arraySort a1 a2 i1 i2 i3 v1 v2 st1 st2 sel1 sel2 ante conseq thm |
	arraySort := Z3Sort int --> Z3Sort int.
	a1 := arraySort mkConst: 'a1'.
	a2 := arraySort mkConst: 'a2'.
	i1 := Z3Sort int mkConst: 'i1'.
	i2 := Z3Sort int mkConst: 'i2'.
	i3 := Z3Sort int mkConst: 'i3'.
	v1 := Z3Sort int mkConst: 'v1'.
	v2 := Z3Sort int mkConst: 'v2'.
	
	st1 := a1 arrayStore: i1 put: v1.
	st2 := a2 arrayStore: i2 put: v2.
	sel1 := a1 arraySelect: i3.
	sel2 := a2 arraySelect: i3.
	
	ante := st1 eq: st2.
	conseq := Bool or: (Array
		with: (i1 eq: i3)
		with: (i2 eq: i3)
		with: (sel1 eq: sel2)).
	thm := ante ==> conseq.
	thm astToString.
	
	s := Z3Solver new.
	s proveValid: thm.
	s release
]

{ #category : #tests }
Z3CAPITest >> testArray2 [
	"Show that distinct(a_0, ... , a_n) is unsatisfiable
	 when a_i's are arrays from boolean to boolean and n > 4.
	 This example also shows how to use the distinct construct."
	| sats |
	sats := (2 to: 5) collect: [ :n | self exampleArray2: n ].
	self assert: sats asArray equals: {  true. true. true. false }

]

{ #category : #tests }
Z3CAPITest >> testArray3 [
	"Simple array type construction/deconstruction example."
	| arraySort |
	arraySort := Int sort --> Bool sort.
	self assert: arraySort domain equals: Int sort.
	self assert: arraySort range equals: Bool sort.
]

{ #category : #tests }
Z3CAPITest >> testBinaryTree [
	"Create a binary tree datatype of the form
		BinTree ::=
			| nil
			| node(value : Int, left : BinTree, right : BinTree)
	"
	| nilCon nodeCon  cell nil1 node1 node2 node3 nilDecl isNilDecl nodeDecl isNodeDecl nodeAccessors valueDecl rightDecl leftDecl |
	nilCon := Z3Constructor
		name: 'nil'
		recognizer: 'is-nil'
		fields: #()
		referencing: #().
	nodeCon := Z3Constructor
		name: 'node'
		recognizer: 'is-node'
		fields: { 'value'->Int sort. 'left'->nil. 'right'->nil }
		referencing: { 0 . 0 . 0 }.
	cell := Z3DatatypeSort name: 'BinTree' constructors: {nilCon.nodeCon}.
	nilDecl := nilCon query first.
	isNilDecl := nilCon query second.
	nodeDecl := nodeCon query first.
	isNodeDecl := nodeCon query second.
	nodeAccessors := nodeCon query third.
	valueDecl := nodeAccessors first.
	leftDecl := nodeAccessors second.
	rightDecl := nodeAccessors third.
	nilCon delete. nodeCon delete.
	"We have our recursive datatype; now do a few things."
	"create nil"
	nil1 := nilDecl value.
	"create node1 ::= node(10, nil, nil)"
	node1 := nodeDecl value: 10 toInt value: nil1 value: nil1.
	"create node2 ::= node(30, node1, nil)"
	node2 := nodeDecl value: 30 toInt value: node1 value: nil1.
	"create node3 ::= node(20, node2, nil)"
	node3 := nodeDecl value: 20 toInt value: node2 value: node1.
	self assert: (nil1 ~== node1) isValid.
	self assert: (nil1 === (leftDecl value: node1)) isValid.
	self assert: (node1 === (rightDecl value: node3)) isValid.
	self assert: (isNilDecl value: node2) not isValid.
	self assert: ((valueDecl value: node2) >= 0) isValid.
]

{ #category : #tests }
Z3CAPITest >> testBitvector1 [
	"Simple bit-vector example.
	This example disproves that x - 10 <= 0 IFF x <= 10 for (32-bit) machine integers."
	| x zero ten |
	x := 'x' toBitVector: 32.
	zero := 0 toBitVector: 32.
	ten := 10 toBitVector: 32.
	self deny: (x <= ten iff: x - ten <= zero) isValid
]

{ #category : #tests }
Z3CAPITest >> testBitvector1a [
	"Just like testBitvector1 but coerces integers to BVs."
	| x |
	x := 'x' toBitVector: 32.
	self deny: (x <= 10 iff: x - 10 <= 0) isValid
]

{ #category : #tests }
Z3CAPITest >> testBitvector2 [
	"Find x and y such that: x ^ y - 103 == x * y"
	| x y solver solution |
	x := 'x' ///32.
	y := 'y' ///32.
	solver := Z3Solver new.
	solver assert: ((x bitXor: y) - 103 === (x * y)).
	self assert: solver check.
	solution := solver getModel constants.
	solver release.
	
	"There are, in fact, many solutions, including
	 (103,0), (0,103), (16rx0e05044b,16r7821741b) etc.
	 Let's check that the one we got, makes sense in
	 ordinary Smalltalk-80."
	x := (solution at: 'x') unsignedValue.
	y := (solution at: 'y') unsignedValue.
	self deny: (x even and: [y even]). "x and y can't be both even"
	self assert: ((x bitXor: y) - 103 equals: (x * y) modulo: (2 raisedTo: 32))

]

{ #category : #tests }
Z3CAPITest >> testBitvector2b [
	"After some naïve experimenting, one might be tempted to conclude
	 that the equality mod 2³² in testBitvector2 even works up to 2³⁴.
	 Here is a counterexample: (103,16rFFFFFFFE).
	 (This test is not part of test_capi.c, but it's so cool that
	 I couldn't resist adding it here.)
	"
	| x y xi yi |
	x := 'x' ///32.
	y := 'y' ///32.
	xi := x toUnsignedInt.
	yi := y toUnsignedInt.
	self deny: (
		(x bitXor: y) - 103 === (x * y)
			==>
		((x bitXor: y) toUnsignedInt - 103 equals: xi*yi modulo: (2 raisedTo: 34))
	) isValid
]

{ #category : #tests }
Z3CAPITest >> testBitvector2c [
	"But the 'x and y can't be both even' theorem is
	 actually correct.  Let's give it to Z3 to prove."
	| x y |
	x := 'x' ///32.
	y := 'y' ///32.
	self assert: (
		(x bitXor: y) - 103 === (x * y)
			==>
		(x even & y even) not
	) isValid
]

{ #category : #tests }
Z3CAPITest >> testBitvector2d [
	"Another way of writing 2c."
	| x y |
	x := 'x' ///32.
	y := 'y' ///32.
	self assert: (
		(x bitXor: y) - 103 === (x * y)
			==>
		(x odd | y odd)
	) isValid
]

{ #category : #tests }
Z3CAPITest >> testDemorgan [
	"Demonstration of how Z3 can be used to prove validity of
	 De Morgan's Duality Law: {e not(x and y) <-> (not x) or ( not y) }"
	| x y notX notY XandY ls rs conjecture negatedConjecture solver sat |

	x := Bool var: 0.
	y := Bool var: 1.
	
	self assert: x isApp.
	
	"De Morgan - with a negation around"
	"!(!(x && y) <-> (!x || !y))"
	notX := x not.
	notY := y not.
	XandY := x & y.
	
	ls := XandY not.
	rs := notX | notY.
	
	conjecture := ls iff: rs.
	negatedConjecture := conjecture not.
	
	solver := Z3Solver new.
	solver assert: negatedConjecture.
	sat := solver check.
	"The negated conjecture was unsatisfiable, hence the conjecture is valid"
	self deny: sat.
	
	solver release

]

{ #category : #tests }
Z3CAPITest >> testEnum [
	"Create an enumeration data type."
	| fruit consts testers apple banana orange fruity solver |
	consts  := Cell new.
	testers := Cell new.
	fruit := Z3DatatypeSort
		mkEnumerationSort: 'fruit'
		elements: { 'apple'. 'banana'. 'orange' }
		consts: consts
		testers: testers.
	"it's instructive to look around the consts and testers at this point"
	apple  := consts get first value.
	banana := consts get second value.
	orange := consts get third value.
	"Apples are different from oranges"
	self assert: apple ~== orange.
	"Apples pass the apple test"
	self assert: (testers get first value: apple) isValid.
	"Oranges fail the apple test"
	self deny: (testers get first value: orange) isValid.
	
	"If something is fruity, then it is an apple, banana, or orange"
	fruity := fruit mkConst: 'fruity'.
	self assert: (Bool or: { fruity===apple. fruity===banana. fruity===orange }) isValid.
	
	"No fruity can ever be an apple and banana at the same time"
	self assert: (Bool and: { fruity===apple. fruity===banana }) not isValid.
	
]

{ #category : #tests }
Z3CAPITest >> testErrorHandling1 [
	| zero ten bvsge |
	
	zero := 0 toInt.
	ten := 10 toInt.
	
	self should: [bvsge := Z3 mk_bvsge: zero ctx _: zero _: ten] raise: Z3Error
]

{ #category : #tests }
Z3CAPITest >> testEval [
	"Demonstrate how to use #Z3_eval."
	| ctx solver x y two m x_plus_y |
	ctx := Z3Context fromDefault.
	x := ctx mkIntVar: 'x'.
	y := ctx mkIntVar: 'y'.
	two := ctx mkInt: 2.
	
	solver := ctx mkSolver.
	solver assert: x < y.
	solver assert: x > two.
	solver check.
	m := solver getModel.
	x_plus_y := m eval: (x+y) completion: true.
	self assert: x_plus_y astToString equals: '7'.
	x_plus_y printOn: Transcript.
	Transcript cr.
	
	"m decRef."
	solver release.
	ctx release
]

{ #category : #tests }
Z3CAPITest >> testFindModel0 [
	"Find a model for
		x "
	| x y solver sat model ass |

	((Smalltalk respondsTo: #isSmalltalkX) and:[Smalltalk isSmalltalkX]) ifTrue:[
		self skip: 'Not supported on Smalltalk/X, uses Pharo compiler API'
	].

	x := Bool var: 'x'.
	y := Bool var: 'y'.
	
	solver := Z3Solver new.
	solver assert: x. " + y."
	sat := solver check.
	
	"this is the test for now; this is part of void check() in test_capi.c"
	self assert: sat.
	model := solver getModel.
	ass := Smalltalk compiler source: (model toString); environment: (Dictionary new at: 'x' put: 'XXX'; yourself); evaluate.
	self assert: ass key equals: 'XXX'.
	self assert: ass value equals: true.
]

{ #category : #tests }
Z3CAPITest >> testFindModel1 [
	"Find a model for
		x xor y "
	| x y solver sat model |
	x := Bool var: 'x'.
	y := Bool var: 'y'.
	
	solver := Z3Solver new.
	solver assert: x + y.
	sat := solver check.
	
	"this is the test for now; this is part of void check() in test_capi.c"
	self assert: sat.
	model := solver getModel.
	Transcript cr; show: model toString
]

{ #category : #tests }
Z3CAPITest >> testFindModel2 [
	"Find a model for
		x < y + 1, x > 2.
	 Then, assert not(x = y), and find another model.
	"
	| solver x y one two yPlusOne c1 c2 sat model |
	x := Int var: 'x'.
	y := Int var: 'y'.
	one := 1 toInt.
	two := 2 toInt.
	yPlusOne := y + one.
	c1 := x < yPlusOne.
	c2 := x > two.

	solver := Z3Solver new.
	solver assert: c1.
	solver assert: c2.
	"this is the test for now; this is part of void check() in test_capi.c"
"	sat := solver check.
	self assert: sat equals: #TRUE.
	model := solver getModel.
	Transcript cr; show: model toString." "x->3, y->3"
	"Now assert not(x = y) in the same solver"
	solver assert: (x eq: y) not.
	sat := solver check.
	self assert: sat.
	model := solver getModel.
	Transcript cr; show: model toString. "x->3, y->4"
	solver release
]

{ #category : #tests }
Z3CAPITest >> testForest [
	"Create a forest of trees.
   forest ::= nil | cons(tree, forest)
   tree   ::= nil | cons(forest, forest)"
	| tree forest nil1con cons1con nil2con cons2con clist1 clist2 sorts nil1decl isNil1decl car1decl cdr1decl cons1decl isCons1decl nil2decl isNil2decl cons2decl isCons2decl car2decl cdr2decl u v x y |
	"build a forest"
	nil1con := Z3Constructor name: 'nil1' recognizer: 'is_nil1' fields: #() referencing: #().
	cons1con := Z3Constructor name: 'cons1' recognizer: 'is_cons1' fields: { 'car'->nil. 'cdr'->nil } referencing: { 1 . 0 }.
	"build a tree"
	nil2con := Z3Constructor name: 'nil2' recognizer: 'is_nil2' fields: #() referencing: #().
	cons2con := Z3Constructor name: 'cons2' recognizer: 'is_cons2' fields: { 'car'->nil. 'cdr'->nil } referencing: { 0 . 0 }.
	
	clist1 := Z3ConstructorList withAll: { nil1con . cons1con }.
	clist2 := Z3ConstructorList withAll: { nil2con . cons2con }.
	
	sorts := Z3DatatypeSort names: { 'forest'. 'tree' } constructorLists: { clist1. clist2 }.
	forest := sorts first.  tree := sorts second.
	nil1decl := nil1con query first.
	isNil1decl := nil1con query second.
	cons1decl := cons1con query first.
	isCons1decl := cons1con query second.
	car1decl := cons1con query third first.
	cdr1decl := cons1con query third second.
	nil2decl := nil2con query first.
	isNil2decl := nil2con query second.
	cons2decl := cons2con query first.
	isCons2decl := cons2con query second.
	car2decl := cons2con query third first.
	cdr2decl := cons2con query third second.
	clist1 delete. clist2 delete.
	nil1con delete. cons1con delete. nil2con delete. cons2con delete.

	self assert: (nil1decl value ~== (cons1decl value: nil2decl value value: nil1decl value)) isValid.
	self assert: (nil2decl value ~== (cons2decl value: nil1decl value value: nil1decl value)) isValid.
	"cons(x,u) = cons(x, v) => u = v"
	u := forest mkConst: 'u'. v := forest mkConst: 'v'.
	x := tree mkConst: 'x'.   y := tree mkConst: 'y'.
	self assert: ((cons1decl value: x value: u) === (cons1decl value: y value: v) ==> (u===v)) isValid.
	self assert: ((cons1decl value: x value: u) === (cons1decl value: y value: v) ==> (x===y)) isValid.
	"any forest is either nil or cons"
	self assert: ((isNil1decl value: u) | (isCons1decl value: u)) isValid.
	"occurs check u != cons(x,u)"
	self assert: (u ~== (cons1decl value: x value: u)) isValid.
]

{ #category : #tests }
Z3CAPITest >> testFunctionDeclaration [
	| fd1 |

	fd1 := ('fd1' toZ3Symbol) mkFuncFrom: { Z3Sort int } to: Z3Sort bool.
	self assert: (fd1 isKindOf: Z3FuncDecl).

	self should:[('fd2' toZ3Symbol) mkFuncFrom: { Z3Sort int } to: true toBool]
		  raise: Error.

	self should:[('fd2' toZ3Symbol) mkFuncFrom: { 1 toInt } to: Z3Sort bool ]
		  raise: Error.
]

{ #category : #tests }
Z3CAPITest >> testITE [
	"Test ite-term (if-then-else terms)."
	| f one zero ite |
	f := Bool false.
	one := 1 toInt.
	zero := 0 toInt.
	ite := f ifThen: one else: zero.
	ite astToString.
]

{ #category : #tests }
Z3CAPITest >> testList [
	"Create a list datatype."
	| intList nilDecl isNilDecl consDecl isConsDecl headDecl tailDecl NIL l1 l2 x y u v fml1 |
	nilDecl := Cell new.
	isNilDecl := Cell new.
	consDecl := Cell new.
	isConsDecl := Cell new.
	headDecl := Cell new.
	tailDecl := Cell new.
	intList := Z3DatatypeSort 
		mkListSort: 'int_list'
		elementSort: Int sort
		nilDecl: nilDecl
		isNilDecl: isNilDecl
		consDecl: consDecl
		isConsDecl: isConsDecl
		headDecl: headDecl
		tailDecl: tailDecl.
	nilDecl := nilDecl get.
	isNilDecl := isNilDecl get.
	consDecl := consDecl get.
	isConsDecl := isConsDecl get.
	headDecl := headDecl get.
	tailDecl := tailDecl get.
	NIL := nilDecl value.
	l1 := consDecl value: 1 value: NIL.
	l2 := consDecl value: 2 value: NIL.
	self assert: (NIL ~== l1) isValid.
	self assert: (l1 ~== l2) isValid.
	x := 'x' toInt.  y := 'y' toInt.
	u := intList mkConst: 'u'. v := intList mkConst: 'v'.
	self assert: (
		(consDecl value: x value: NIL) === (consDecl value: y value: NIL)
			==>
		(x===y)
	) isValid.
	self assert: (
		(consDecl value: x value: u) === (consDecl value: y value: v)
			==>
		(x===y)
	) isValid.
	self assert: (
		(consDecl value: x value: u) === (consDecl value: y value: v)
			==>
		(u===v)
	) isValid.
	self assert: (
		(isNilDecl value: u) | (isConsDecl value: u)
	) isValid.
	self assert: (
		u ~== (consDecl value: x value: u) "occurs check"
	) isValid.
	"destructors: u = cons(head(u),tail(u)) if isCons(u)"
	fml1 := u === (consDecl value: (headDecl value: u) value: (tailDecl value: u)).
	self deny: fml1 isValid.
	self assert: ((isConsDecl value: u) ==> fml1) isValid
]

{ #category : #tests }
Z3CAPITest >> testNumeral [
	"Demonstrate different ways of creating rational numbers: decimal and fractional representations."
	| s real_sort n1 n2 |
	s := Z3Solver new.
	"create a big number"
	real_sort := Z3Sort real.
	n1 := real_sort numeralFrom: '-1/3'.
	n2 := real_sort numeralFrom: '-0.33333333333333333333333333333333333333333333333333'.
	s proveValid: (n1 eq: n2) not.
	s release
]

{ #category : #tests }
Z3CAPITest >> testProve1 [
	"Prove x = y implies g(x) = g(y), and
   disprove x = y implies g(g(x)) = g(y).

   This function demonstrates how to create uninterpreted types and
   functions."
	| solver U g x y gx gy ggx |
	U := Z3Sort uninterpretedSortNamed: 'U'.
	
	"declare function g"
	g := 'g' functionFrom: (Array with: U) to: U.
	
	x := U mkConst: 'x'.
	y := U mkConst: 'y'.
	
	gx := g value: x.
	gy := g value: y.
	
	solver := Z3Solver new.
	solver assert: (x eq: y).
	solver proveValid: (gx eq: gy).
	ggx := g value: gx.
	self flag: #TODO.  "I don't understand why the below fails to prove a counterexample"
	"solver proveNotValid: (ggx eq: gy)."
	solver release.
]

{ #category : #tests }
Z3CAPITest >> testPushPop [
	"Show how push & pop can be used to create 'backtracking' points.
   This example also demonstrates how big numbers can be created in Z3."
	| ctx s brazilion int_sort x y  big_number three |
	ctx := Z3Context fromDefault.
	s := ctx mkSolver.
	
	"create a big number"
	int_sort := ctx mkIntSort.
	brazilion := '1000000000000000000000000000000000000000000000000000000'.
	big_number := int_sort numeralFrom: brazilion.
	self assert: big_number astToString equals: brazilion.
	
	"create number 3"
	three := int_sort numeralFrom: '3'.
	self assert: three astToString equals: '3'.
	
	"create x, assert x > brazilion"
	x := ctx mkIntVar: 'x'.
	s assert: x > big_number.
	
	"create a backtracking point"
	self assert: s numScopes equals: 0.
	s push.
	self assert: s numScopes equals: 1.
	
	"assert x < 3, which is inconsistent with x > brazilion"
	s assert: x < three.
	self assert: s check == false.
	
	"backtrack: the constraint x <= 3 will be removed,
	since it was sserted after the last Z3_solver_push."
	s pop.
	self assert: s numScopes equals: 0.

	"the context is consistent again."
	self assert: s check == true.

	"new constraints can be asserted..."

	"create y"
	y := ctx mkIntVar: 'y'.
	s assert: y > x.
	"the context is still consistent"
	self assert: s check == true.
	"s getModel inspect."
	
	s release.
	ctx release
]

{ #category : #tests }
Z3CAPITest >> testQuantifier [
	"Prove that
		f(x, y) = f(w, v)
	implies
		y = v
	when f is injective in the second argument."
	| f solver x y w v fxy fwv |
	Z3 global_param_set: 'smt.mbqi.max_iterations' _: '10'.
	
	f := 'f' functionFrom: { Int sort. Int sort. } to: Int sort.
	solver := Z3Solver new.
	solver assertInjective: f in: 2.
	x := Int var: 'x'.
	y := Int var: 'y'.
	v := Int var: 'v'.
	w := Int var: 'w'.
	fxy := f value: x value: y.
	fwv := f value: w value: v.
	solver assert: (fxy eq: fwv).
	solver push.
	solver proveValid: (y eq: v).
	solver pop.
	"However, because nothing says f is injective in the first argument,
	trying to prove x=w fails:"
	self should: [solver proveValid: (x eq: w)] raise: UnknownValidity
]

{ #category : #tests }
Z3CAPITest >> testSMT2Parser [
	"Demonstrates how to use SMT2 parser."
	| fs |
	fs := Z3ASTVector parseSmtlib2String: '(declare-fun a () (_ BitVec 8)) (assert (bvuge a #x10)) (assert (bvule a #xf0))'.
	self assert: (fs printString beginsWith: '(ast-vector')
	
]

{ #category : #tests }
Z3CAPITest >> testSubstituteSubexpressions [
	"Demonstrates how to use the function Z3_substitute to replace subexpressions in a Z3 AST."
	| Z a b f g fab ga ffabga r |
	Z := Z3Sort int.
	a := 'a' toInt.  	b := 'b' toInt.
	f := 'f' functionFrom: {Z.Z} to: Z.
	g := 'g' functionFrom: {Z} to: Z.
	fab := f value: a value: b. "f(a,b)"
	ga := g value: a. "g(a)"
	ffabga := f value: fab value: ga. "f(f(a,b), g(a))"
	
	r := ffabga substituteAll: {b. ga} with: {0 toInt. 1 toInt}.
	r astToString.
	self assert: r isApp.
	self assert: r arity equals: 2.
	self assert: (r argAt: 2) astToString equals: '1'

]

{ #category : #tests }
Z3CAPITest >> testSubstituteVars [
	"Demonstrates how to to replace free variables with expressions in an AST."
	| x0 x1 a b gb f g f01 ff010 r intTy |
	intTy := Z3Sort int.
	x0 := intTy mkBound: 0.
	x1 := intTy mkBound: 1.
	f := 'f'
		functionFrom: (Array with: intTy with: intTy)
		to: intTy.
	g := 'g'
		functionFrom: (Array with: intTy)
		to: intTy.
	f01 := f value: x0 value: x1. "f(x0,x1)"
	ff010 := f value: f01 value: x0. "f(f(x0,x1),x0)"
	a := Int var: 'a'.
	b := Int var: 'b'.
	gb := g value: b. "g(b)"
	"Replace x0 -> a, x1 -> g(b) in f(f(x0,x1),x0),
	giving f(f(a,g(b)),a)"
	r := ff010 substituteVarsWith: (Array with: a with: gb).
	self assert: r astToString equals: '(f (f a (g b)) a)'.
	self assert: r isInt.
	self assert: r isApp.
	self assert: r functorName equals: 'f'.
	self assert: (r argAt: 2) astToString equals: 'a'

]

{ #category : #tests }
Z3CAPITest >> testTuple1 [
	"Simple tuple type example.
	 Create a tuple that is a pair of real numbers."
	| R mkTuple projDecls pairSort |
	R := Real sort.
	mkTuple := Cell new.
	projDecls := Cell new.
	pairSort := Z3DatatypeSort
		mkTupleSort: 'mk_pair'
		projections:  { 'get_x'->R . 'get_y'->R }
		mkTupleDecl: mkTuple
		projDecls: projDecls.
	mkTuple := mkTuple get. projDecls := projDecls get.
	"prove that get_x(mk_pair(x,y)) = 1 implies x = 1"
	self assert: (
		(projDecls first value: (mkTuple value: 'x' value: 'y')) === 1 toReal
		 ==>
		(1 toReal === 'x')) isValid.
	"disprove that get_x(mk_pair(x,y)) = 1 implies y = 1"
	self deny: (
		(projDecls first value: (mkTuple value: 'x' value: 'y')) === 1 toReal
		 ==>
		(1 toReal === 'y')) isValid.

]

{ #category : #tests }
Z3CAPITest >> testUnsatCore [
	"Prove a theorem and extract, and print the proof.
	This example illustrates the use of #Z3_check_assumptions."
	| pa pb pc pd p1 p2 p3 p4 f1 f2 f3 f4 result assumptions solver |
	pa := 'PredA' toBool. pb := 'PredB' toBool. pc := 'PredC' toBool. pd := 'PredD' toBool.
	p1 := 'P1' toBool. p2 := 'P2' toBool. p3 := 'P3' toBool. p4 := 'P4' toBool.
	assumptions := {p1.p2.p3.p4.} collect: #not.
	f1 := Bool and: { pa. pb. pc. }.
	f2 := Bool and: { pa. pb not. pc. }.
	f3 := Bool and: { pa not. pc not. }.
	f4 := pd.
	solver := Z3Solver new.
	solver assert: (Bool or: { f1.p1. }).
	solver assert: (Bool or: { f2.p2. }).
	solver assert: (Bool or: { f3.p3. }).
	solver assert: (Bool or: { f4.p4. }).
	result := solver checkAssumptions: assumptions.
	self assert: result == false.
	self assert: solver unsatCore size equals: 2.
	"solver proof." "TODO"
	solver release
	
]

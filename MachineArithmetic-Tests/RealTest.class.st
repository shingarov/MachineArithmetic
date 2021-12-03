Class {
	#name : #RealTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-SMT'
}

{ #category : #tests }
RealTest >> testAlgebraicRoot [
	| x t s r i |

	self skip: 'Skipping since Z3_algebraic_get_i() seem to be missing in Z3 4.8.7 available on CI'.

	x := 'x' toReal.
	t := (x * x) - 2.
	s := Z3Solver new.
	s assert: t === 0.
	s assert: x <= 0.
	s check.
	r := s getModel eval: x completion: true.
	i := Z3 algebraic_get_i: r ctx _: r.     

	self skip: 'Does not work for as yet unknown reason'.

	self assert: i equals: 1.
]

{ #category : #tests }
RealTest >> testAlgebraicRoots0 [
	| x p roots |

	x := Real sort mkBound: 0.
	p := (x * x) - 2.

	roots := Z3 algebraic_roots: p ctx _: p _: 0 _: #().
	self assert: (roots isKindOf: Z3ASTVector).
	self assert: (roots size == 2).
]

{ #category : #tests }
RealTest >> testAlgebraicRoots1 [
	"
	Taken from: https://github.com/Z3Prover/z3/blob/master/src/api/python/z3/z3num.py
	"
	| x0 x1 x2 p roots |

	x0 := Real sort mkBound: 0.
	x1 := Real sort mkBound: 1.
	x2 := Real sort mkBound: 2.

	p := (x0 ** 5) - x0 - 1.
	roots := Z3 algebraic_roots: p ctx _: p _: 0 _: #().

	self assert: (roots isKindOf: Z3ASTVector).
	self assert: (roots size == 1).
]

{ #category : #tests }
RealTest >> testAlgebraicRoots2 [
	"
	Taken from: https://github.com/Z3Prover/z3/blob/master/src/api/python/z3/z3num.py
	"
	| x0 x1 p roots |

	x0 := Real sort mkBound: 0.
	x1 := Real sort mkBound: 1.

	self assert: (Z3 algebraic_is_value: Z3Context current _: (3 toReal ** (1/2)) simplify ).

	p := (x0 ** 2) - (x1 ** 4) - 1.
	roots := Z3 algebraic_roots: p ctx _: p _: 1 _: { (3 toReal ** (1/2)) simplify }.

	self assert: (roots isKindOf: Z3ASTVector).
	self assert: (roots size == 2).
]

{ #category : #tests }
RealTest >> testAlgebraicRoots3 [
	"
	Taken from: https://github.com/Z3Prover/z3/blob/master/src/api/python/z3/z3num.py
	"
	| x0 x1 x2 p roots |

	x0 := Real sort mkBound: 0.
	x1 := Real sort mkBound: 1.
	x2 := Real sort mkBound: 2.

	p := (x2 ** 2) + x0 - x1.
	roots := Z3 algebraic_roots: p ctx _: p _: 2 _: { 3 toReal sqrt simplify . 2 toReal sqrt simplify }.

	self assert: (roots isKindOf: Z3ASTVector).
	self assert: (roots size == 0).
]

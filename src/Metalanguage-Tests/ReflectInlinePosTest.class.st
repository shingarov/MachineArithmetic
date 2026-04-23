Class {
	#name : #ReflectInlinePosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'Metalanguage-Tests'
}

{ #category : #running }
ReflectInlinePosTest >> parserClass [
	^ΛοParser
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_42 [
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  42
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  fortyTwo(a)
};
'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_42_chain [
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  42
};

⟦reflect fortyTwoX : int => int⟧
let fortyTwoX = (x) => {
  fortyTwo(x)
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwoX(a);
  z
};
'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_42_chain2 [
"Chain PLE with inline"
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  42
};

⟦reflect fortyTwoX : int => int / [0 toInt]⟧
let rec fortyTwoX = (x) => {
  fortyTwo(x)
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwoX(a);
  z
};
'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_42_chain_longer [
	"A longer chain of 3 reflects, inlined."
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  42
};

⟦reflect fortyTwoX : int => int⟧
let fortyTwoX = (x) => {
  let y = fortyTwo(x);
  y + 1
};

⟦reflect fortyTwoXX : int => int⟧
let fortyTwoXX = (x) => {
  let y = fortyTwoX(x);
  y - 1
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwoXX(a);
  z
};
'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_42_inner [
	self processString: '
⟦val junk : int => int⟧
let junk = (ign) => { 0 };

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  42
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  fortyTwo(a)
};
'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_IncInc [
	self processString: '
[--check-termination]

⟦reflect inc : int => int⟧
let inc = (a) => {
  let t = a + 1;
  t
};

⟦reflect inc2 : int => int⟧
let inc2 = (x) => {
  let y = inc(x);
  let z = inc(y);
  z
};

⟦val main : int => int[v | v===3]⟧
let main = (arg) => {
  let three = inc2(1);
  three
};
'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_abs_01 [
	self processString: '
	[--check-termination]

	⟦reflect bb002 : int => int⟧
	let bb002 = (y) => {
		y
	};

	⟦reflect abs : int => int⟧
	let abs = (x) => {
		let cond = x > 0;
		if (cond) {
			x
		} else {
			0 - x
		}
	};

	⟦val verify : int => bool[b|b]⟧
	let verify = (z) => {
		let got = abs(z);
		got >= 0
	};
	'.
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_abs_02 [
	self processString: '
	[--check-termination]

	⟦reflect bb002 : int => int⟧
	let bb002 = (x) => {
		x
	};

	⟦reflect abs : int => int⟧
	let abs = (x) => {
		let cond = x > 0;
		if (cond) {
			bb002(x)
		} else {
			0 - x
		}
	};

	⟦val verify : int => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		got >= 0
	};
	'.
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_adder [
	self processString: '
[--check-termination]

⟦reflect adder : int => int => int⟧
let adder = (x, y) => {
  let z = x + y;
  z
};

⟦val main : int => int[v | v===11]⟧
let main = (a) => {
  let eleven = adder(5, 6);
  eleven
};
'
]

{ #category : #'tests-ADT' }
ReflectInlinePosTest >> test_id_01a [
	self proveSafe: '
⟦reflect id : x:BitVec(Size32) => BitVec(Size32)⟧
let id = (x) => {
    x
};
	
⟦val verify : BitVec(Size32) => bool[b|b]⟧
let verify = (x) => {
    let exp = x;
    let got = id(x);
    bveq(exp, got)
};
'
]

{ #category : #'tests-ADT' }
ReflectInlinePosTest >> test_id_01b [
	self proveSafe: '
⟦val iload : c:BitVec(Size32) => BitVec(Size32)[v|v===c]⟧
let iload = (c) => {
    c
};	
	
⟦val ireturn : c1:BitVec(Size32) => BitVec(Size32)[v|v===c1]⟧
let ireturn = (c1) => {
    c1
};
	
⟦reflect id : x:BitVec(Size32) => BitVec(Size32)⟧
let rec id = (x) => {
    let N002 = iload(x);
    ireturn(N002)
};
	
⟦val verify : BitVec(Size32) => bool[b|b]⟧
let verify = (x) => {
    let exp = x;
    let got = id(x);
    bveq(got, exp)
};
'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_inc [
	self processString: '
[--check-termination]

⟦reflect inc : int => int⟧
let inc = (x) => {
  let y = x + 1;
  y
};

⟦val main : int => int[v | v===43]⟧
let main = (a) => {
  let two = inc(42);
  two
};
'
]

{ #category : #'tests-ADT' }
ReflectInlinePosTest >> test_mkA [
	self processString: '
type a_or_b =
  | A => [v|v === A]
  | B => [v|v === B]
  ;

⟦reflect mkA : int => a_or_b⟧
let mkA = (a) => {
  let t = A;
  t
};

⟦val main : int => a_or_b[v | v===A]⟧
let main = (arg) => {
  mkA(0)
};
'
]

{ #category : #'tests-ADT' }
ReflectInlinePosTest >> test_point1 [
	self processString: '
type point =
  | P (x:int, y:int) => [v|v === (P value: x value: y)]
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val check : m:int => int ⟧
let check = (m) => {
    let p = P(42, 43);
    switch (p){
      | P(px, py) => let ok = px == 42;
                     cassert(ok)
    }
};
'
]

{ #category : #'tests-ADT' }
ReflectInlinePosTest >> test_point2 [
	self processString: '
type point =
  | P (x:int, y:int) => [v|v === (P value: x value: y)]
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦reflect mkPoint : x:int => y:int => point⟧
let mkPoint = (x,y) => {
    P(x, y)
};

⟦val check : m:int => int ⟧
let check = (m) => {
    let p = mkPoint(42, 43);
    switch (p){
      | P(px, py) => let ok = px == 42;
                     cassert(ok)
    }
};
'
]

{ #category : #'tests-ADT' }
ReflectInlinePosTest >> test_point3 [
	self processString: '
type point =
  | P (x:int, y:int) => [v|v === (P value: x value: y)]
  ;

⟦reflect mkPoint : x:int => y:int => point⟧
let mkPoint = (x,y) => {
    P(x, y)
};

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val check : m:int => int ⟧
let check = (m) => {
    let p = mkPoint(42, 43);
    switch (p){
      | P(px, py) => let ok = px == 42;
                     cassert(ok)
    }
};
'
]

{ #category : #'tests-ADT' }
ReflectInlinePosTest >> test_point_anf [
	self processString: '
type point =
  | P (x:int, y:int) => [v|v === (P value: x value: y)]
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val check : m:int => int ⟧
let check = (m) => {
    switch (P(42, 43)){
      | P(px, py) => let ok = px == 42;
                     cassert(ok)
    }
};
'
]

{ #category : #'tests-bitvector' }
ReflectInlinePosTest >> test_pos_02 [
	self processString: '
	[--check-termination]

	⟦val zero : BitVec(Size32)[v|v===(0///32)]⟧
	let zero = toBitVector(0);
	⟦val one : BitVec(Size32)[v|v===(1///32)]⟧
	let one = toBitVector(1);

	⟦reflect pos : BitVec(Size32) => BitVec(Size32)⟧
	let pos = (x) => {
		let cond = bvsge(x, zero);
		if (cond) {
			one
		} else {
			zero
		}
	};

	⟦val verify : BitVec(Size32) => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		let isOne = got == one;
		let isZer = got == zero;
		isOne || isZer
	};
	'.
]

{ #category : #'tests-bitvector' }
ReflectInlinePosTest >> test_pos_02b [
	self processString: '
	[--check-termination]
	⟦val zero : BitVec(Size32)[v|v===(0///32)]⟧
	let zero = toBitVector(0);
	⟦val one : BitVec(Size32)[v|v===(1///32)]⟧
	let one = toBitVector(1);
	
	⟦reflect pos : BitVec(Size32) => BitVec(Size32)⟧
	let pos = (x) => {
		let cond = bvsge(x, zero);
		if (cond) {
			one
		} else {
			zero
		}
	};

	⟦val verify : BitVec(Size32) => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		bvsge(got, zero)
	};
	'.
]

{ #category : #'tests-bitvector' }
ReflectInlinePosTest >> test_pos_03 [
	self processString: '
	[--check-termination]
	⟦val zero : BitVec(Size32)[v|v===(0///32)]⟧
	let zero = toBitVector(0);
	⟦val one : BitVec(Size32)[v|v===(1///32)]⟧
	let one = toBitVector(1);
	
	⟦reflect pos : BitVec(Size32) => BitVec(Size32)⟧
	let pos = (x) => {
		let cond = bvsge(x, zero);
		if (cond) {
			one
		} else {
			bvsub(x,x)
		}
	};

	⟦val verify : BitVec(Size32) => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		let isOne = got == one;
		let isZer = got == zero;
		isOne || isZer
	};
	'.
]

{ #category : #'tests-bitvector' }
ReflectInlinePosTest >> test_pos_04 [
	self skip.
	self processString: '
	[--check-termination]

	⟦reflect pos : bv32 => bv32⟧
	let pos = (x) => {
		let cond = bvge32(x, bv32(0));
		if (cond) {
			x
		} else {
			bvsub32(x,x)
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		let isOne = got == x;
		let isZer = got == bv32(0);
		isOne || isZer
	};
	'.
]

{ #category : #'tests-bitvector' }
ReflectInlinePosTest >> test_pos_05 [
	self skip.
	self processString: '
	[--check-termination]

	⟦reflect pos : bv32 => bv32⟧
	let pos = (x) => {
		let cond = bvge32(x, bv32(0));
		if (cond) {
			x
		} else {
			bvsub32(x,x)
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		bvge32(got, bv32(0))
	};
	'.
]

{ #category : #'tests-bitvector' }
ReflectInlinePosTest >> test_trabs_02 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int⟧
	let iload = (s) => {
		s
	};

	⟦reflect iconst : int => int⟧
	let iconst = (s) => {
		s
	};

	⟦reflect isub : int => int => int⟧
	let isub = (c1, c2) => {
		let r = c1 - c2;
		r
	};

	⟦reflect icmpgt : int => int => bool⟧
	let icmpgt = (c1, c2) => {
		c1 > c2
	};


	⟦reflect ireturn : int => int⟧
	let ireturn = (c1) => {
		c1
	};

	⟦reflect bb002 : int => int⟧
	let bb002 = (x) => {
		let n10 = iload(x);
		let n11 = ireturn(n10);
		n11
	};

	⟦reflect abs : int => int⟧
	let  abs = (x) => {
		let n01 = iload(x);
		let n02 = iconst(0);
		let cond = icmpgt(n01,n02);
		if (cond) {
			bb002(x)
		} else {
			let n03 = isub(n02,n01);
			let n04 = ireturn(n03);
			n04
		}
	};

	⟦val verify : int => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		got >= 0
	};
	'.
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_tradd2_01 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int⟧
	let iload = (s) => {
		s
	};

	⟦reflect iconst : int => int⟧
	let iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int⟧
	let iadd = (c1, c2) => {
		c1 + c2
	};


	⟦reflect ireturn : int => int⟧
	let ireturn = (c1) => {
		c1
	};

	⟦val verify : int => bool[b|b]⟧
	let verify = (x) => {
				let exp = x + 2;

				let n01 = iload(x);
				let n02 = iconst(2);
				let n03 = iadd(n01,n02);
				let n04 = ireturn(n03);

				let got = n04;
				got == exp
	    };
	'
]

{ #category : #'tests-integer' }
ReflectInlinePosTest >> test_tradd2_02 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int⟧
	let iload = (s) => {
		s
	};

	⟦reflect iconst : int => int⟧
	let iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int⟧
	let iadd = (c1, c2) => {
		let r = c1 + c2;
		r
	};


	⟦reflect ireturn : int => int⟧
	let ireturn = (c1) => {
		c1
	};

	⟦reflect add2 : int => int⟧
	let add2 = (x) => {
		let n01 = iload(x);
		let n02 = iconst(2);
		let n03 = iadd(n01,n02);
		let n04 = ireturn(n03);
		n04
	};

	⟦val verify : int => bool[b|b]⟧
	let verify = (x) => {
		let exp = x + 2;

		let got = add2(x);
		got == exp
	};
	'.
]

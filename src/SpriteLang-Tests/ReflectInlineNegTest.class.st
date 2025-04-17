Class {
	#name : #ReflectInlineNegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
ReflectInlineNegTest >> test_42 [
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  43
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwo(a);
  z
};
'
]

{ #category : #tests }
ReflectInlineNegTest >> test_abs_03 [
	"Demonstrate the power of Z3 bitfiddling.
	 If would seem that this case is just like test_abs_02 but using bitvectors,
	 however the prover can not be fooled by this subtle bug!
	 Cf. SimpleBitVectorTest>>testAbs."
	self processString: '
	[--check-termination]

	⟦reflect bb002 : BitVec(Size32) => BitVec(Size32)⟧
	let bb002 = (x) => {
		x
	};

	⟦reflect abs : BitVec(Size32) => BitVec(Size32)⟧
	let abs = (x) => {
		let zero = toBitVector(0);
		let cond = bvsgt(x, zero);
		if (cond) {
			bb002(x)
		} else {
			bvsub(zero, x)
		}
	};

	⟦val verify : BitVec(Size32) => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		bvsge(got, zero)
	};
	'.
]

{ #category : #tests }
ReflectInlineNegTest >> test_abs_04 [
	"Demonstrate the power of Z3 bitfiddling.
	 If would seem that this case is just like test_abs_02 but using bitvectors,
	 however the prover can not be fooled by this subtle bug!
	 Cf. SimpleBitVectorTest>>testAbs."
	self processString: '
	[--check-termination]
	⟦val zero : BitVec(Size32)[v|v===(0///32)]⟧
	let zero = toBitVector(0);

	⟦reflect abs : BitVec(Size32) => BitVec(Size32)⟧
	let abs = (x) => {
		let cond = bvsgt(x, zero);
		if (cond) {
			x
		} else {
			bvsub(zero, x)
		}
	};

	⟦val verify : BitVec(Size32) => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		bvsge(got, zero)
	};
	'.
]

{ #category : #tests }
ReflectInlineNegTest >> test_trabs_03 [
	"Demonstrate the power of Z3 bitfiddling.
	 If would seem that this case is just like test_abs_02 but using bitvectors,
	 however the prover can not be fooled by this subtle bug!
	 Cf. SimpleBitVectorTest>>testAbs."
	self processString: '
	[--check-termination]

	⟦reflect iload : BitVec(Size32) => BitVec(Size32)⟧
	let iload = (s) => {
		s
	};

	⟦reflect iconst : BitVec(Size32) => BitVec(Size32)⟧
	let iconst = (s) => {
		s
	};

	⟦reflect isub : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
	let isub = (c1, c2) => {
		let r = bvsub(c1, c2);
		r
	};

	⟦reflect icmpgt : BitVec(Size32) => BitVec(Size32) => bool⟧
	let icmpgt = (c1, c2) => {
		bvsgt(c1, c2)
	};


	⟦reflect ireturn : BitVec(Size32) => BitVec(Size32)⟧
	let ireturn = (c1) => {
		c1
	};

	⟦reflect bb002 : BitVec(Size32) => BitVec(Size32)⟧
	let bb002 = (x) => {
		let n10 = iload(x);
		let n11 = ireturn(n10);
		n11
	};

	⟦reflect abs : BitVec(Size32) => BitVec(Size32)⟧
	let abs = (x) => {
		let n01 = iload(x);
		let n02 = iconst(zero);
		let cond = icmpgt(n01,n02);
		if (cond) {
			bb002(x)
		} else {
			let n03 = isub(n02,n01);
			let n04 = ireturn(n03);
			n04
		}
	};

	⟦val zero : BitVec(Size32)[v|v===(0///32)]⟧
	let zero = toBitVector(0);

	⟦val verify : BitVec(Size32) => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		bvsge(got, zero)
	};
	'.
]

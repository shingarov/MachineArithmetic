Class {
	#name : #ReflectFailingTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
ReflectFailingTest >> test_42_chain3 [
"Chain inline with PLE; opposite from chain2"
	self proveSafe: '
[--check-termination]

⟦reflect fortyTwo : int => int / [0 toInt]⟧
let rec fortyTwo = (x) => {
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

{ #category : #tests }
ReflectFailingTest >> test_abs_03 [
	"Just like test_abs_02 but using bitvectors"
	self proveSafe: '
	[--check-termination]

	⟦reflect bb002 : bv32 => bv32⟧
	let bb002 = (x) => {
		x
	};

	⟦reflect abs : bv32 => bv32⟧
	let abs = (x) => {
		let cond = bvgt32(x, bv32(0));
		if (cond) {
			bb002(x)
		} else {
			bvsub32(bv32(0), x)
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		bvge32(got, bv32(0))
	};
	'.
]

{ #category : #tests }
ReflectFailingTest >> test_abs_04 [
	"Just like test_abs_03 but not calling continuation.
	 Also like test_pos_05 excpt call to bvsub32 in else branch
	"
	self proveSafe: '
	[--check-termination]

	⟦reflect abs : bv32 => bv32⟧
	let abs = (x) => {
		let cond = bvgt32(x, bv32(0));
		if (cond) {
			x
		} else {
			bvsub32(bv32(0), x)
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		bvge32(got, bv32(0))
	};
	'.
]

{ #category : #tests }
ReflectFailingTest >> test_trabs_03 [
	"Just like test_trabs_02 but using bitvectors"
	self proveSafe: '
	[--check-termination]

	⟦reflect iload : bv32 => bv32⟧
	let iload = (s) => {
		s
	};

	⟦reflect iconst : bv32 => bv32⟧
	let iconst = (s) => {
		s
	};

	⟦reflect isub : bv32 => bv32 => bv32⟧
	let isub = (c1, c2) => {
		let r = bvsub32(c1, c2);
		r
	};

	⟦reflect icmpgt : bv32 => bv32 => bool⟧
	let icmpgt = (c1, c2) => {
		bvgt32(c1, c2)
	};


	⟦reflect ireturn : bv32 => bv32⟧
	let ireturn = (c1) => {
		c1
	};

	⟦reflect bb002 : bv32 => bv32⟧
	let bb002 = (x) => {
		let n10 = iload(x);
		let n11 = ireturn(n10);
		n11
	};

	⟦reflect abs : bv32 => bv32⟧
	let  abs = (x) => {
		let n01 = iload(x);
		let n02 = iconst(bv32(0));
		let cond = icmpgt(n01,n02);
		if (cond) {
			bb002(x)
		} else {
			let n03 = isub(n02,n01);
			let n04 = ireturn(n03);
			n04
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = abs(x);
		bvge32(got, bv32(0))
	};
	'.
]

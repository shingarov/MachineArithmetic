Class {
	#name : #L8PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L8PosTest >> test_42 [
	self skip:'See #test_42b'.
	self processString: '
[--check-termination]
⟦reflect fortyTwo : int => int / [0]⟧
let rec fortyTwo = (x) => {
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
L8PosTest >> test_42b [
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  42
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwo(a);
  z
};
'
]

{ #category : #tests }
L8PosTest >> test_42b_chain [
	"Demonstrate a simple chain of reflects."
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

{ #category : #tests }
L8PosTest >> test_42b_chain_longer [
	"Demonstrate a simple chain of reflects."
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

{ #category : #tests }
L8PosTest >> test_IncInc [
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

{ #category : #tests }
L8PosTest >> test_PleInc [
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

{ #category : #tests }
L8PosTest >> test_abs_01 [
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

{ #category : #tests }
L8PosTest >> test_abs_02 [
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

{ #category : #tests }
L8PosTest >> test_abs_03 [
	"Just like test_abs_02 but using bitvectors"
	self processString: '
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
L8PosTest >> test_abs_04 [
	"Just like test_abs_03 but not calling continuation.
	 Also like test_pos_05 excpt call to bvsub32 in else branch
	"
	self processString: '
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
L8PosTest >> test_adder [
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

{ #category : #tests }
L8PosTest >> test_adder_chain [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect adder : int => int => int / [zero]⟧
let rec adder = (x, y) => {
  let z = x + y;
  z
};

⟦reflect twice : int => int / [zero]⟧
let rec twice = (x) => {
  let y = adder(x, x);
  y
};

⟦val main : int => int[v | v===4]⟧
let main = (a) => {
  let four = twice(2);
  four
};
'
]

{ #category : #tests }
L8PosTest >> test_adder_chain_semiReflect [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect adder : int => int => int / [zero]⟧
let rec adder = (x, y) => {
  let z = x + y;
  z
};

⟦val twice : x:int => int[v | 2 * x === v] / [zero]⟧
let rec twice = (x) => {
  let y = adder(x, x);
  y
};

⟦val main : int => int[v | v===4]⟧
let main = (a) => {
  let four = twice(2);
  four
};
'
]

{ #category : #tests }
L8PosTest >> test_addorsub_01 [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect add : int => int => int / [zero]⟧
let rec add = (x, y) => {
  let z = x + y;
  z
};

⟦reflect sub : int => int => int / [zero]⟧
let rec sub = (x, y) => {
  let z = x - y;
  z
};


⟦reflect addorsub : int => int => int / [zero]⟧
let rec addorsub = (x, y) => {
	let positive = x > 0;
	if (positive) { 
		add(x,y)
	} else { 
		sub(x,y)
	}
};

⟦val main : int => int[v | v===11]⟧
let main = (a) => {
  let eleven = addorsub(5, 6);
  eleven
};
'
]

{ #category : #tests }
L8PosTest >> test_addorsub_02 [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect add : int => int => int / [zero]⟧
let rec add = (x, y) => {
  let z = x + y;
  z
};

⟦reflect sub : int => int => int / [zero]⟧
let rec sub = (x, y) => {
  let z = x - y;
  z
};

⟦reflect positive : int => bool / [zero]⟧
let rec positive = (x) => {
	x >= 0
};


⟦reflect addorsub : int => int => int / [zero]⟧
let rec addorsub = (x, y) => {
	let pos = positive(x);
	if (pos) { 
		add(x,y)
	} else { 
		sub(x,y)
	}
};

⟦val main : int => int[v | v===11]⟧
let main = (a) => {
  let eleven = addorsub(5, 6);
  eleven
};
'
]

{ #category : #tests }
L8PosTest >> test_addorsub_03 [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect add : int => int => int / [zero]⟧
let rec add = (x, y) => {
  let z = x + y;
  z
};

⟦reflect sub : int => int => int / [zero]⟧
let rec sub = (x, y) => {
  let z = x - y;
  z
};

⟦reflect positive : int => bool / [zero]⟧
let rec positive = (x) => {
	x >= 0
};

⟦reflect shit : int => int => bool => int / [zero]⟧
let rec shit = (x, y, cond) => {
	if (cond) { 
		add(x,y)
	} else { 
		sub(x,y)
	}
};


⟦reflect addorsub : int => int => int / [zero]⟧
let rec addorsub = (x, y) => {
	let pos = positive(x);
	shit(x,y,pos)
};

⟦val main : int => int[v | v===11]⟧
let main = (a) => {
  let eleven = addorsub(5, 6);
  eleven
};
'
]

{ #category : #tests }
L8PosTest >> test_addorsub_chain [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect addorsub : int => int => int / [zero]⟧
let rec addorsub = (x, y) => {
	let positive = x > 0;
	if (positive) { 
		x + y
	} else { 
		x - y
	}
};

⟦reflect twice : int => int / [zero]⟧
let rec twice = (x) => {
  let y = addorsub(x, x);
  y
};

⟦val main : int => int[v | v===10]⟧
let main = (a) => {
  let ten = twice(5);
  ten
};
'
]

{ #category : #tests }
L8PosTest >> test_pos_02 [
	self processString: '
	[--check-termination]

	⟦reflect pos : bv32 => bv32⟧
	let pos = (x) => {
		let cond = bvge32(x, bv32(0));
		if (cond) {
			bv32(1)
		} else {
			bv32(0)
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		let isOne = got == bv32(1);
		let isZer = got == bv32(0);
		isOne || isZer
	};
	'.
]

{ #category : #tests }
L8PosTest >> test_pos_02b [
	self processString: '
	[--check-termination]

	⟦reflect pos : bv32 => bv32⟧
	let pos = (x) => {
		let cond = bvge32(x, bv32(0));
		if (cond) {
			bv32(1)
		} else {
			bv32(0)
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		bvge32(got, bv32(0))
	};
	'.
]

{ #category : #tests }
L8PosTest >> test_pos_03 [
	self processString: '
	[--check-termination]

	⟦reflect pos : bv32 => bv32⟧
	let pos = (x) => {
		let cond = bvge32(x, bv32(0));
		if (cond) {
			bv32(1)
		} else {
			bvsub32(x,x)
		}
	};

	⟦val verify : bv32 => bool[b|b]⟧
	let verify = (x) => {
		let got = pos(x);
		let isOne = got == bv32(1);
		let isZer = got == bv32(0);
		isOne || isZer
	};
	'.
]

{ #category : #tests }
L8PosTest >> test_pos_04 [
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

{ #category : #tests }
L8PosTest >> test_pos_05 [
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

{ #category : #tests }
L8PosTest >> test_static_assert_eq [
	self processString: '
	[--check-termination]
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect static_assert_eq : ''t => ''t => bool[b|b] / [zero]⟧
	let rec static_assert_eq = (got, exp) => {
		got == exp
	};

	⟦val verify : int => bool[b|b]⟧
	let verify = (x) => {
		static_assert_eq(x,x)
	};
	'.
]

{ #category : #tests }
L8PosTest >> test_sum100 [
	self processString: '
[--check-termination]
⟦reflect sum : n:int => int / [n]⟧
let rec sum = (n) => {
  let base = n <= 0;
  if (base) {
    0
  } else {
    let n1 = n - 1;
    let t1 = sum(n1);
    n + t1
  }
};

⟦val sum_100_eq_5050 : int => int[v| (sum value: 100) === 5050]⟧
let sum_100_eq_5050 = (n) => {0};
'
]

{ #category : #tests }
L8PosTest >> test_sumGauss [
	self processString: '
[--check-termination]
⟦reflect sum : n:int => int / [n]⟧
let rec sum = (n) => {
  let base = n <= 0;
  if (base) {
    0
  } else {
    let n1 = n - 1;
    let t1 = sum(n1);
    n + t1
  }
};

⟦val thm_sum : n:int[v| 0 <= v] => int[w| 2 * (sum value: n) === (n+1 * n)] / [n]⟧
let rec thm_sum = (n) => {
  let base = n <= 0;
  if (base) {
    0
  } else {
    let n1 = n - 1;
    thm_sum(n1)
  }
};
'
]

{ #category : #tests }
L8PosTest >> test_trabs_02 [
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

{ #category : #tests }
L8PosTest >> test_trabs_03 [
	"Just like test_trabs_02 but using bitvectors"
	self processString: '
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

{ #category : #tests }
L8PosTest >> test_tradd2_01 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int / [zero]⟧
	let iload = (s) => {
		s
	};

	⟦reflect iconst : int => int / [zero]⟧
	let iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int / [zero]⟧
	let iadd = (c1, c2) => {
		c1 + c2
	};


	⟦reflect ireturn : int => int / [zero]⟧
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
	'.
]

{ #category : #tests }
L8PosTest >> test_tradd2_02 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int / [zero]⟧
	let iload = (s) => {
		s
	};

	⟦reflect iconst : int => int / [zero]⟧
	let iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int / [zero]⟧
	let iadd = (c1, c2) => {
		let r = c1 + c2;
		r
	};


	⟦reflect ireturn : int => int / [zero]⟧
	let ireturn = (c1) => {
		c1
	};

	⟦reflect add2 : int => int / [zero]⟧
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

{ #category : #tests }
L8PosTest >> test_trid_01 [
	self processString: '
	[--check-termination]
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect iload : int => int / [zero]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect ireturn : int => int / [zero]⟧
	let rec ireturn = (c1) => {
		c1
	};

	⟦val verify : int => bool[b|b]⟧
	    let verify = (x) => {
				let exp = x;

				let n01 = iload(x);
				let n02 = ireturn(n01);

				let got = n02;
				got == exp
	    };
	'.
]

{ #category : #tests }
L8PosTest >> test_trid_02 [
	self processString: '
	[--check-termination]
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect iload : int => int / [zero]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect ireturn : int => int / [zero]⟧
	let rec ireturn = (c1) => {
		c1
	};

	⟦reflect id : int => int / [zero]⟧
	let rec id = (x) => {
		let n01 = iload(x);
		let n02 = ireturn(n01);
		n02
	};

	⟦val verify : int => bool[b|b]⟧
	    let verify = (x) => {
				let exp = x;

				let got = id(x);

				got == exp
	    };
	'.
]

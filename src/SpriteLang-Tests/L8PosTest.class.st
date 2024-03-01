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

⟦val zero : int[v | v===0]⟧
let zero = 0;

⟦reflect fortyTwo : int => int / [zero]⟧
let rec fortyTwo = (x) => {
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

⟦val zero : int[v | v===0]⟧
let zero = 0;

⟦reflect fortyTwo : int => int / [zero]⟧
let rec fortyTwo = (x) => {
  42
};

⟦reflect fortyTwoX : int => int / [zero]⟧
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

{ #category : #tests }
L8PosTest >> test_IncInc [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect inc : int => int / [zero]⟧
let rec inc = (x) => {
  let y = x + 1;
  y
};

⟦reflect inc2 : int => int / [zero]⟧
let rec inc2 = (x) => {
  let y = inc(x);
  let z = inc(y);
  z
};

⟦val main : int => int[v | v===3]⟧
let main = (a) => {
  let three = inc2(1);
  three
};
'
]

{ #category : #tests }
L8PosTest >> test_PleInc [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect inc : int => int / [zero]⟧
let rec inc = (x) => {
  let y = x + 1;
  y
};

⟦val main : int => int[v | v===2]⟧
let main = (a) => {
  let two = inc(1);
  two
};
'
]

{ #category : #tests }
L8PosTest >> test_abs_01 [
	self processString: '
	[--check-termination]
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect bb002 : int => int / [zero]⟧
	let rec bb002 = (x) => {
		x
	};

	⟦reflect abs : int => int / [zero]⟧
	let rec abs = (x) => {
		let cond = x > 0;
		if (cond) {
			x
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
L8PosTest >> test_abs_02 [
	self processString: '
	[--check-termination]
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect bb002 : int => int / [zero]⟧
	let rec bb002 = (x) => {
		x
	};

	⟦reflect abs : int => int / [zero]⟧
	let rec abs = (x) => {
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
L8PosTest >> test_adder [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect adder : int => int => int / [zero]⟧
let rec adder = (x, y) => {
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

{ #category : #'tests-safety' }
L8PosTest >> test_poly [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect maxInt : x:int => y:int => int / [zero]⟧ 
let maxInt = (x, y) => { 
  let b = x < y;
  if (b){
    y 
  } else { 
    x 
  } 
};

⟦val test1 : a:int[v|0 < v] => b:int[v|0 < v] => int[v|0 < v]⟧ 
let test1 = (a, b) => { 
  maxInt(a, b)
};

⟦val test2 : a:int[v|v < 0] => b:int[v|v < 0] => int[v|v < 0]⟧ 
let test2 = (a, b) => { 
  maxInt(a, b)
};
'
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

⟦val thm_sum : m:int[v| 0 <= v] => int[w| 2 * (sum value: m) === (m+1 * m)] / [n]⟧
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
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect iload : int => int / [zero]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect iconst : int => int / [zero]⟧
	let rec iconst = (s) => {
		s
	};

	⟦reflect isub : int => int => int / [zero]⟧
	let rec isub = (c1, c2) => {
		let r = c1 - c2;
		r
	};

	⟦reflect icmpgt : int => int => bool / [zero]⟧
	let rec icmpgt = (c1, c2) => {
		c1 > c2
	};


	⟦reflect ireturn : int => int / [zero]⟧
	let rec ireturn = (c1) => {
		c1
	};

	⟦reflect bb002 : int => int / [zero]⟧
	let rec bb002 = (x) => {
		let n10 = iload(x);
		let n11 = ireturn(n10);
		n11
	};

	⟦reflect abs : int => int / [zero]⟧
	let rec abs = (x) => {
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
L8PosTest >> test_tradd2_01 [
	self processString: '
	[--check-termination]
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect iload : int => int / [zero]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect iconst : int => int / [zero]⟧
	let rec iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int / [zero]⟧
	let rec iadd = (c1, c2) => {
		c1 + c2
	};


	⟦reflect ireturn : int => int / [zero]⟧
	let rec ireturn = (c1) => {
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
	⟦val zero : int[v | v===0]⟧
	let zero = 0;

	⟦reflect iload : int => int / [zero]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect iconst : int => int / [zero]⟧
	let rec iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int / [zero]⟧
	let rec iadd = (c1, c2) => {
		let r = c1 + c2;
		r
	};


	⟦reflect ireturn : int => int / [zero]⟧
	let rec ireturn = (c1) => {
		c1
	};

	⟦reflect add2 : int => int / [zero]⟧
	let rec add2 = (x) => {
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

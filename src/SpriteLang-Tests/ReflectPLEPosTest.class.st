Class {
	#name : #ReflectPLEPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_42 [
	self processString: '
[--check-termination]
⟦reflect fortyTwo : int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_42_chain [
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int / [0 toInt]⟧
let rec fortyTwo = (x) => {
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
ReflectPLEPosTest >> test_42_chain2 [
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
ReflectPLEPosTest >> test_adder [
	self processString: '
[--check-termination]

⟦reflect adder : int => int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_adder_chain [
	self processString: '
[--check-termination]

⟦reflect adder : int => int => int / [0 toInt]⟧
let rec adder = (x, y) => {
  let z = x + y;
  z
};

⟦reflect twice : int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_addorsub_01 [
	self processString: '
[--check-termination]
⟦reflect add : int => int => int / [0 toInt]⟧
let rec add = (x, y) => {
  let z = x + y;
  z
};

⟦reflect sub : int => int => int / [0 toInt]⟧
let rec sub = (x, y) => {
  let z = x - y;
  z
};

⟦reflect addorsub : int => int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_addorsub_02 [
	self processString: '
[--check-termination]
⟦reflect add : int => int => int / [0 toInt]⟧
let rec add = (x, y) => {
  let z = x + y;
  z
};

⟦reflect sub : int => int => int / [0 toInt]⟧
let rec sub = (x, y) => {
  let z = x - y;
  z
};

⟦reflect positive : int => bool / [0 toInt]⟧
let rec positive = (x) => {
	x >= 0
};

⟦reflect addorsub : int => int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_addorsub_03 [
	self processString: '
[--check-termination]
⟦reflect add : int => int => int / [0 toInt]⟧
let rec add = (x, y) => {
  let z = x + y;
  z
};

⟦reflect sub : int => int => int / [0 toInt]⟧
let rec sub = (x, y) => {
  let z = x - y;
  z
};

⟦reflect positive : int => bool / [0 toInt]⟧
let rec positive = (x) => {
	x >= 0
};

⟦reflect shit : int => int => bool => int / [0 toInt]⟧
let rec shit = (x, y, cond) => {
	if (cond) { 
		add(x,y)
	} else { 
		sub(x,y)
	}
};

⟦reflect addorsub : int => int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_addorsub_chain [
	self processString: '
[--check-termination]
⟦reflect addorsub : int => int => int / [0 toInt]⟧
let rec addorsub = (x, y) => {
	let positive = x > 0;
	if (positive) { 
		x + y
	} else { 
		x - y
	}
};

⟦reflect twice : int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_inc [
	self processString: '
[--check-termination]

⟦reflect inc : int => int / [0 toInt]⟧
let rec inc = (x) => {
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_incinc [
	self processString: '
[--check-termination]

⟦reflect inc : int => int / [0 toInt]⟧
let rec inc = (a) => {
  let t = a + 1;
  t
};

⟦reflect inc2 : int => int / [0 toInt]⟧
let rec inc2 = (x) => {
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
ReflectPLEPosTest >> test_tradd2_01 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int / [0 toInt]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect iconst : int => int / [0 toInt]⟧
	let rec iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int / [0 toInt]⟧
	let rec iadd = (c1, c2) => {
		c1 + c2
	};


	⟦reflect ireturn : int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_tradd2_02 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int / [0 toInt]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect iconst : int => int / [0 toInt]⟧
	let rec iconst = (s) => {
		s
	};

	⟦reflect iadd : int => int => int / [0 toInt]⟧
	let rec iadd = (c1, c2) => {
		let r = c1 + c2;
		r
	};

	⟦reflect ireturn : int => int / [0 toInt]⟧
	let rec ireturn = (c1) => {
		c1
	};

	⟦reflect add2 : int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_trid_01 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int / [0 toInt]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect ireturn : int => int / [0 toInt]⟧
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

{ #category : #'tests-integer' }
ReflectPLEPosTest >> test_trid_02 [
	self processString: '
	[--check-termination]

	⟦reflect iload : int => int / [0 toInt]⟧
	let rec iload = (s) => {
		s
	};

	⟦reflect ireturn : int => int / [0 toInt]⟧
	let rec ireturn = (c1) => {
		c1
	};

	⟦reflect id : int => int / [0 toInt]⟧
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

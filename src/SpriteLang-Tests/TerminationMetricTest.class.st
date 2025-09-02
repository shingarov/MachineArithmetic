Class {
	#name : #TerminationMetricTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
TerminationMetricTest >> test_ack [
	"Same as in L7, but do not check termination"
	self proveSafe: '
⟦val ack : m:int[v|0 <= v] => n:int[v|0 <= v] => int[v|0 <= v]⟧
let rec ack = (m, n) => {
  let condm = m == 0;
  let condn = n == 0;
  if (condm) {
    n + 1
  } else {
    let m1 = m - 1;
    if (condn) {
      ack (m1, 1)
    } else {
      let n1 = n - 1;
      let r  = ack(m, n1);
      ack (m1, r)
    }
  }
};
'
]

{ #category : #tests }
TerminationMetricTest >> test_dead_branch [
	self proveSafe: '
⟦reflect bb_003 : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let rec bb_003 = (x, i) => {
    let N017 = i;
    N017
};

⟦reflect bb_001 : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let rec bb_001 = (x, i) => {
    let five = toBitVector(5);
    let cond = bvsge(i, five);
    if (cond) {
        bb_003(x, i)
    } else {
        let tmp1 = toBitVector(1);
        let N009 = tmp1;
        let N010 = bvadd(i, N009);
        let i = N010;
        bb_001(x, i)
    }
};

⟦reflect dead_branch : BitVec(Size32) => BitVec(Size32)⟧
let rec dead_branch = (x) => {
    let fortyTwo = toBitVector(42);
    bb_001(x, fortyTwo)
};

⟦val verify : BitVec(Size32) => bool[b|b]⟧
let verify = (x) => {
	let exp = toBitVector(42);
	let got = dead_branch(x);
	got == exp
};
'
]

{ #category : #tests }
TerminationMetricTest >> test_dead_branch_2 [
	self proveSafe: '
⟦reflect bb_003 : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let rec bb_003 = (x, i) => {
    let N017 = i;
    N017
};

⟦reflect bb_001 : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let rec bb_001 = (x, i) => {
    let five = toBitVector(5);
    let cond = bvsge(i, five);
    if (cond) {
        bb_003(x, i)
    } else {
        let zzz = 0;
        let yyy = 1234;
        let tmp1 = toBitVector(1);
        let N009 = tmp1;
        let N010 = bvadd(i, N009);
        let i = N010;
        bb_001(x, i)
    }
};

⟦reflect dead_branch : BitVec(Size32) => BitVec(Size32)⟧
let rec dead_branch = (x) => {
    let fortyTwo = toBitVector(42);
    bb_001(x, fortyTwo)
};

⟦val verify : BitVec(Size32) => bool[b|b]⟧
let verify = (x) => {
	let exp = toBitVector(42);
	let got = dead_branch(x);
	got == exp
};
'
]

{ #category : #tests }
TerminationMetricTest >> test_nonrec [
	self proveSafe: '
[--check-termination]
⟦val fortyTwo : x:int => int[v|v === 42] / [0 toInt]⟧
let rec fortyTwo = (x) => {
  42
};
'
]

Class {
	#name : #L7NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L7NegTest >> test_ack [
	self processString: '
[--check-termination]
/*@ val ack : m:int[v|0 <= v] => n:int[v|0 <= v] => int / [m], [n] */
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
L7NegTest >> test_sum [
	self processString: '
[--check-termination]
/*@ val sum : n:int => int[v|0 <= v] / [n] */
let rec sum = (n) => {
    let cond = n == 0;
    if (cond) {
        0
    } else {
        let n1 = n-1;
        let t1 = sum(n1);
        n + t1
    }
};
'
]

{ #category : #tests }
L7NegTest >> test_sum02 [
	self processString: '
[--check-termination]
⟦val sum : x:int => int[v|0 <= v] / [x]⟧
let rec sum = (n) => {
    let cond = n == 0;
    if (cond) {
        0
    } else {
        let n1 = n-1;
        let t1 = sum(n1);
        n + t1
    }
};
'
]

{ #category : #tests }
L7NegTest >> test_sumAcc [
	self processString: '
[--check-termination]
/*@ val sumAcc : total:int => n:int => int / [total] */
let rec sumAcc = (total, n) => {
  let cond = n <= 0;
  if (cond) {
    total
  } else {
    let n1 = n - 1;
    let tot1 = total + n;
    sumAcc(tot1, n1)
  }
};
'
]

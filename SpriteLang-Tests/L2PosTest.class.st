Class {
	#name : #L2PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-safety' }
L2PosTest >> test_abs00 [
	self processString: '
/*@ val abs : x:int => int[v|0<=v] */
let abs = (x) => { 
    let pos = x >= 0; 
    if (pos) {
        x
    } else {
        0 - x
    }
};
'
]

{ #category : #'tests-safety' }
L2PosTest >> test_abs01 [
	self processString: '
/*@ val abs : x:int => int[v| (0<=v) & (x <= v)] */
let abs = (x) => { 
    let pos = x >= 0; 
    if (pos) {
        x
    } else {
        0 - x
    }
};

/*@ val test : a:int => b:int => int[v|(0<=v) & (a + b <= v)] */
let test = (a, b) => {
    let t1 = abs(a);
    let t2 = abs(b);
    t1 + t2
};
'
]

{ #category : #'tests-safety' }
L2PosTest >> test_cmp00 [
	self processString: '
/*@ val cmp : x:int => bool[b|b <=> (x < 10)] */
let cmp = (x) => {
    let cond = x < 10;
    if (cond) {
        true
    } else {
        false
    }
};
'
]

{ #category : #'tests-safety' }
L2PosTest >> test_cmp01 [
	self processString: '
/*@ val cmp : x:int => y:int => bool[b|b <=> (x < y)] */
let cmp = (x, y) => {
    let cond = x < y;
    if (cond) {
        true
    } else {
        false
    }
};
'
]

{ #category : #'tests-safety' }
L2PosTest >> test_sum00 [
	self processString: '
/*@ val sum : n:int => int[v|0 <= v & (n <= v)] */
let rec sum = (n) => {
    let cond = n <= 0;
    if (cond) {
        0
    } else {
        let n1 = n - 1;
        let t1 = sum(n1);
        n + t1
    }
};
'
]

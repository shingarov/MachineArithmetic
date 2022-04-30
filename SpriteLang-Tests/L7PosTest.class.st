Class {
	#name : #L7PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-safety' }
L7PosTest >> test_ack [
	self processString: '
⟦ val ack : m:int[v|0 <= v] => n:int[v|0 <= v] => int[v|0 <= v] / m, n ⟧
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

{ #category : #'tests-safety' }
L7PosTest >> test_append [
	self processString: '
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L7PosTest >> test_braid [
	self processString: '
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L7PosTest >> test_listSet [
	self processString: '
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L7PosTest >> test_range [
	self processString: '
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L7PosTest >> test_sum [
	self processString: '
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L7PosTest >> test_sumAcc [
	self processString: '
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L7PosTest >> test_sumNat [
	self processString: '
	
	
⟦ ⟧




'
]

Class {
	#name : #L6PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-safety' }
L6PosTest >> test_apply00 [
	self processString: '
	
	  deptup000.re  deptup001.re  deptup002a.re  deptup002.re  deptup003.re  deptup00.re  isort02.re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_deptup00 [
	self processString: '
	
	  .re  .re  .re  .re  .re  .re  isort02.re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_deptup000 [
	self processString: '
	
	  .re  deptup001.re  deptup002a.re  deptup002.re  deptup003.re  deptup00.re  isort02.re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_deptup001 [
	self processString: '
	
	  .re  .re  deptup002a.re  deptup002.re  deptup003.re  deptup00.re  isort02.re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_deptup002 [
	self processString: '
	
	  .re  .re  .re  .re  deptup003.re  deptup00.re  isort02.re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_deptup002a [
	self processString: '
	
	  .re  .re  .re  deptup002.re  deptup003.re  deptup00.re  isort02.re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_deptup003 [
	self processString: '
	
	  .re  .re  .re  .re  .re  deptup00.re  isort02.re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_isort02 [
	self processString: '
	
	  .re  .re  .re  .re  .re  .re  .re  maxint.re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_maxint [
	self processString: '
⟦val maxInt : ∀ (p : int => bool). x:int[v|p v] => y:int[v|p v] => int[v|p v]⟧ 
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

{ #category : #'tests-safety' }
L6PosTest >> test_maxlist00 [
	self processString: '
	
	  .re  .re  .re  .re  .re  .re  .re  .re  .re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_maxlist01 [
	self processString: '
	
	  .re  .re  .re  .re  .re  .re  .re  .re  .re  .re  maxpoly.re
	
	
⟦ ⟧




'
]

{ #category : #'tests-safety' }
L6PosTest >> test_maxpoly [
	self processString: '
	
	
⟦ ⟧




'
]

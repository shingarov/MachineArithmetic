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
	
	  .re  .re  .re  .re  .re  .re  .re  .re  maxlist00.re  maxlist01.re  maxpoly.re
	
	
⟦ ⟧




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

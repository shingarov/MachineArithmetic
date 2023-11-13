Class {
	#name : #Z3IntSort,
	#superclass : #Z3Sort,
	#category : #'Z3-Core'
}

{ #category : #inhabitation }
Z3IntSort >> anyOne [
	^0 toInt
]

{ #category : #'type theory' }
Z3IntSort >> cast: val [
	^val toInt
]

{ #category : #'type theory' }
Z3IntSort >> nodeClass [
	^ Int

]

{ #category : #'element creation' }
Z3IntSort >> number: anInteger [ 
	^anInteger toInt
]

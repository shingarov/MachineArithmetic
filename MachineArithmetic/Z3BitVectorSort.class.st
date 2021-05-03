Class {
	#name : #Z3BitVectorSort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #accessing }
Z3BitVectorSort >> length [
	"Return length in bits"
	^ Z3 get_bv_sort_size: ctx _: self

]

{ #category : #'type theory' }
Z3BitVectorSort >> nodeClass [
	^ BitVector

]

{ #category : #printing }
Z3BitVectorSort >> printString [
	^ 'Z3Sort bv:',self length printString

]

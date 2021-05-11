Class {
	#name : #Z3QuantifierNode,
	#superclass : #Bool,
	#category : #'MachineArithmetic-Core'
}

{ #category : #testing }
Z3QuantifierNode >> isExists [
	^ Z3 is_quantifier_exists: ctx _: self

]

{ #category : #testing }
Z3QuantifierNode >> isForAll [
	^ Z3 is_quantifier_forall: ctx _: self

]

{ #category : #printing }
Z3QuantifierNode >> printString [
	^ self astToString

]

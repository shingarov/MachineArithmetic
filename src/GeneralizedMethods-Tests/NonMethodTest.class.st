"
Tests in this TestCase form one sequence and must be performed in alphabetic order.

At the beginning, class ObjectWithNonMethodMorphism has two methods (#a and #z) in its MethodDictionary.

First, we add an ExampleMorphism as #f.  If we ran #testAddMorphism manually, we can use the IDE for a while to see that the compatibility methods in ExampleMorphism make the Calypso IDE happy.

Second, #testInvoke sends #f and checks that it executes successfully.

Finally, #testRemoveMorphism cleans up.
"
Class {
	#name : #NonMethodTest,
	#superclass : #TestCase,
	#category : #'GeneralizedMethods-Tests'
}

{ #category : #'tests-morphisms' }
NonMethodTest >> testAddMorphism [
	ObjectWithNonMethodMorphism methodDict
		at: #f
		put: ExampleMorphism new
]

{ #category : #'tests-running' }
NonMethodTest >> testInvoke [
	self
		assert: ObjectWithNonMethodMorphism new f
		equals: 'f'
]

{ #category : #'tests-morphisms' }
NonMethodTest >> testRemoveMorphism [
	(ObjectWithNonMethodMorphism>>#f) removeFromSystem
]

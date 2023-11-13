Class {
	#name : #SingletonBoolTest,
	#superclass : #TestCase,
	#category : #'Z3-Tests-SMT'
}

{ #category : #tests }
SingletonBoolTest >> testEqualLeft [
	| ast |
	ast := 'x' toInt === 'y' toInt.
	self assert: (ast singletonExpr: 'x') equals: 'y' toInt
]

{ #category : #tests }
SingletonBoolTest >> testEqualNeither [
	| ast |
	ast := 'x' toInt === 'y' toInt.
	self assert: (ast singletonExpr: 'a') isNil
]

{ #category : #tests }
SingletonBoolTest >> testEqualRight [
	| ast |
	ast := 'x' toInt === 'y' toInt.
	self assert: (ast singletonExpr: 'y') equals: 'x' toInt
]

{ #category : #tests }
SingletonBoolTest >> testIffLeft [
	| ast |
	ast := 'p' toBool <=> 'q' toBool.
	self assert: (ast singletonExpr: 'p') equals: 'q' toBool
]

{ #category : #tests }
SingletonBoolTest >> testNonBool [
	| ast |
	ast := 'x' toInt.
	self assert: (ast singletonExpr: 'a') isNil
]

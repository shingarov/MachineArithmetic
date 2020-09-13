Class {
	#name : #SendMoreMoneyTest,
	#superclass : #TestCase,
	#instVars : [
		'solver'
	],
	#category : #'MachineArithmetic-Tests'
}

{ #category : #running }
SendMoreMoneyTest >> setUp [
	Z3Context createGlobalContext.
	solver := Solver new
]

{ #category : #running }
SendMoreMoneyTest >> tearDown [
	solver del.
	Z3Context current del
]

{ #category : #tests }
SendMoreMoneyTest >> test1 [
	| vars s e n d m o r y model |
	vars := #(s e n d m o r y) collect: [ :x |
		Int var: x asString ].

	s := vars at: 1.  	e := vars at: 2.
	n := vars at: 3.  	d := vars at: 4.
	m := vars at: 5.  	o := vars at: 6.
	r := vars at: 7.  	y := vars at: 8.
	
	vars do: [ :x | 	solver assert: (x >= 0); assert: (x <= 9) ].
	solver assert: (m eq: 0) not.
	solver assert: (solver ctx mkDistinct: vars).
	solver assert: (
		d + (n*10) + (e*100) + (s*1000) "SEND"
		+ e + (r*10) + (o*100) + (m*1000) "MORE"
		eq:
		y + (e*10) + (n*100) + (o*1000) + (m*10000) "MONEY"
		).
	self assert: solver check.
	model := solver getModel constants.
	self assert: (model at: 'y')	 equals: '2'.	
	self assert: (model at: 'd')	 equals: '7'.
]

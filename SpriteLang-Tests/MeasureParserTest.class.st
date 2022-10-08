Class {
	#name : #MeasureParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Parser'
}

{ #category : #tests }
MeasureParserTest >> test1 [
	| m name preSort |
	m := MeasureParser new end parse: 'measure len : list(''a) => int'.
	name := m key.
	preSort := m value.
	self assert: name equals: 'len'
]

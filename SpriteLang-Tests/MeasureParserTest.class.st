Class {
	#name : #MeasureParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Parser'
}

{ #category : #tests }
MeasureParserTest >> test1 [
	| m |
	m := MeasureParser new end parse: 'measure len : list(''a) => int'.
	m halt
]

Class {
	#name : #ZipTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
ZipTest >> testBad [
	self should: [#(1 2 3) zip: #(100)] raise: Error
]

{ #category : #tests }
ZipTest >> testGood [
	self assert: (#(1 2 3) zip: #(100 200 300))
		equals: { 1->100 . 2->200 . 3-> 300 }

]

{ #category : #tests }
ZipTest >> testUnzip3 [
	self assert: (
			{ #(a1 a2 a3) . #(b1 b2 b3) } unzip: 3
		) size
		equals: 3
]

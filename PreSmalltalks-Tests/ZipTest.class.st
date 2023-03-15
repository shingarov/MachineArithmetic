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

{ #category : #tests }
ZipTest >> testZipWith1 [
	"'Example 1' in http://zvon.org/other/haskell/Outputprelude/zipWith_f.html"
	self assert: (#(1 2 3) zip: #(3 2 1) with: [ :x :y | x+y ])
		equals: { 4 . 4 . 4 }

]

{ #category : #tests }
ZipTest >> testZipWith3 [
	"'Example 3' in http://zvon.org/other/haskell/Outputprelude/zipWith_f.html"
	self assert: ((1 to: 4) zip: (5 to: 8) with: [ :x :y | 2*x+y ])
		equals: { 7 . 10 . 13 . 16 }

]

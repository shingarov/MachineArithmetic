Class {
	#name : #DeductionRuleTest,
	#superclass : #TestCase,
	#category : #'Deduction-Tests'
}

{ #category : #examples }
DeductionRuleTest >> example1 [
	^Rule
		premisses: #(A B)
		conclusion: #C
		name: 'Ax'
]

{ #category : #examples }
DeductionRuleTest >> example2 [
	| d1 d |
	d1 := Rule
		premisses: #(1)
		conclusion: 1234567890
		name: 'INTRO'.
	d := Rule
		premisses: {d1 . 2}
		conclusion: 3
		name: 'ELIM'.
	^d
]

{ #category : #examples }
DeductionRuleTest >> test1 [
	| r |
	r := self example1.
	
]

{ #category : #examples }
DeductionRuleTest >> testGT [
	| r |
	r := self example2.
	r asTextMorph halt
]

{ #category : #examples }
DeductionRuleTest >> testGTXX [
	| r f |
	f := '/home/boris/boris2.jpg' asFileReference.
	r := self example2.
	r asTextMorph halt
]

Class {
	#name : #ReaderTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
ReaderTest >> testRunIntegers [
	[
		self assert: Integer fresh equals: 0.
		[ 
			self assert: Integer fresh equals: 0.
			self assert: Integer fresh equals: 1.
			self assert: Integer fresh equals: 2.
			self assert: Integer fresh equals: 3.
		] runWithIncrementingIntegers.
		self assert: Integer fresh equals: 1.
	] runWithIncrementingIntegers
]

{ #category : #tests }
ReaderTest >> testRunReader [
	[ self assert: (Context readState: #a) equals: 42 ] runReader: #a initialState: 42
]

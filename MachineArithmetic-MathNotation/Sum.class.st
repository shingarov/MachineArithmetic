Class {
	#name : #Sum,
	#superclass : #Object,
	#category : #'MachineArithmetic-MathNotation'
}

{ #category : #'as yet unclassified' }
Sum class >> metavars [
	^Metavars current
]

{ #category : #accessing }
Sum class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping | mapping reader: [ :jsonReader |
			| decoderThisTime |
			decoderThisTime := SumConstructorDecoder jsonReader: jsonReader sumClass: self.
			jsonReader parseListDo: [ decoderThisTime := decoderThisTime next ].
			decoderThisTime object
		]].
]

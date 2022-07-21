Class {
	#name : #RTypeParser,
	#superclass : #RefinementParser,
	#category : #SpriteLang
}

{ #category : #grammar }
RTypeParser >> annot [
	^self tyBindP: 'val'
]

{ #category : #grammar }
RTypeParser >> start [
	^self annot annotationBrackets trim
]

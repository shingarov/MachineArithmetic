"
I represent a Gentzen–Jaśkowski derivation rule.

See Gentzen, Gerhard, 1934, “Untersuchungen über das logische Schließen. I & II”,
Mathematische Zeitschrift, 39: 176–210 and 405–431.
doi:10.1007/BF01201353
doi:10.1007/BF01201363.

English translation: “Investigations into Logical Deduction”,
American Philosophical Quarterly, 1: 288–306 (1964), and 2: 204–218 (1965).
"
Class {
	#name : #Rule,
	#superclass : #Object,
	#instVars : [
		'premisses',
		'conclusion',
		'name'
	],
	#category : #Deduction
}

{ #category : #'instance creation' }
Rule class >> premisses: ps conclusion: c name: aString [
	^self basicNew
		premisses: ps;
		conclusion: c;
		name: aString;
		yourself
]

{ #category : #accessing }
Rule >> conclusion [
	^ conclusion
]

{ #category : #accessing }
Rule >> conclusion: anObject [
	conclusion := anObject
]

{ #category : #GT }
Rule >> gtInspectorJpegIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite morph
			title: 'Rule';
			display: [ self asTextMorph ]
]

{ #category : #accessing }
Rule >> name [
	^ name
]

{ #category : #accessing }
Rule >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Rule >> premisses [
	^ premisses
]

{ #category : #accessing }
Rule >> premisses: anObject [
	premisses := anObject
]

{ #category : #printing }
Rule >> printOn: aStream [
	aStream
		nextPutAll: 'Rule ';
		nextPutAll: name
]

Class {
	#name : #AbstractC,
	#superclass : #Object,
	#instVars : [
		'env',
		'rhs',
		'id',
		'tag',
		'info'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #accessing }
AbstractC >> env [
	^ env
]

{ #category : #accessing }
AbstractC >> env: anObject [
	env := anObject
]

{ #category : #GT }
AbstractC >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite text
		title: self textTabLabel;
		display: [ self textForGT ]
]

{ #category : #accessing }
AbstractC >> id [
	^ id
]

{ #category : #accessing }
AbstractC >> id: anObject [
	id := anObject
]

{ #category : #accessing }
AbstractC >> info [
	^ info
]

{ #category : #accessing }
AbstractC >> info: anObject [
	info := anObject
]

{ #category : #accessing }
AbstractC >> rhs [
	^ rhs
]

{ #category : #accessing }
AbstractC >> rhs: anObject [
	rhs := anObject
]

{ #category : #accessing }
AbstractC >> tag [
	^ tag
]

{ #category : #accessing }
AbstractC >> tag: anObject [
	tag := anObject
]

{ #category : #GT }
AbstractC >> textForGT [
	^self textForGT_base, self textForGT_subclassSpecific, self textForGT_meta
]

{ #category : #GT }
AbstractC >> textForGT_base [
	^
	'env: ', env printString, String cr,
	'rhs: ', rhs printString, String cr
]

{ #category : #GT }
AbstractC >> textForGT_meta [
	| s |
	s :=
			'id: ', id printString.
			tag  isNil ifFalse: [ s := s, String cr, 'tag: ', tag printString ].
			info isNil ifFalse: [ s := s, String cr, 'info: ', info printString ].
	^s
]

{ #category : #GT }
AbstractC >> textForGT_subclassSpecific [
	self subclassResponsibility
]

{ #category : #GT }
AbstractC >> textTabLabel [
	self subclassResponsibility
]

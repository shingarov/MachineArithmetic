Class {
	#name : #Prog,
	#superclass : #Object,
	#instVars : [
		'quals',
		'meas',
		'expr',
		'data'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
Prog class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Prog class >> quals: quals meas: meas expr: expr data: data [
	^self basicNew
		quals: quals; meas: meas; expr: expr; data: data;
		yourself
]

{ #category : #accessing }
Prog >> data [
	^ data
]

{ #category : #accessing }
Prog >> data: anObject [
	data := anObject
]

{ #category : #accessing }
Prog >> expr [
	^ expr
]

{ #category : #accessing }
Prog >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
Prog >> meas [
	^ meas
]

{ #category : #accessing }
Prog >> meas: anObject [
	meas := anObject
]

{ #category : #accessing }
Prog >> quals [
	^ quals
]

{ #category : #accessing }
Prog >> quals: anObject [
	quals := anObject
]

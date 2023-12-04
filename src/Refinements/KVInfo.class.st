"
Information about a KVar.

NB: 'domain' is specific to Smalltalk.
"
Class {
	#name : #KVInfo,
	#superclass : #Object,
	#instVars : [
		'kvVar',
		'kvParams',
		'kvWfC',
		'domain'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
KVInfo class >> new [
	"Please use HVar>>kvInfo:."
	self shouldNotImplement
]

{ #category : #accessing }
KVInfo >> domain [
	^ domain
]

{ #category : #accessing }
KVInfo >> domain: anObject [
	domain := anObject
]

{ #category : #accessing }
KVInfo >> kvParams [
	^ kvParams
]

{ #category : #accessing }
KVInfo >> kvParams: anObject [
	kvParams := anObject
]

{ #category : #accessing }
KVInfo >> kvVar [
	^ kvVar
]

{ #category : #accessing }
KVInfo >> kvVar: anObject [
	kvVar := anObject
]

{ #category : #accessing }
KVInfo >> kvWfC [
	^ kvWfC
]

{ #category : #accessing }
KVInfo >> kvWfC: anObject [
	kvWfC := anObject
]

{ #category : #printing }
KVInfo >> printOn: aStream [
	aStream nextPut: $$.
	aStream nextPutAll: kvVar.
	aStream nextPut: $(.
	kvParams printOn: aStream delimiter: ', '.
	aStream nextPutAll: ') '.
	kvWfC printOn: aStream
]

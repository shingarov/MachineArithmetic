Class {
	#name : #FunSig,
	#superclass : #Object,
	#instVars : [
		'fsTVars',
		'fsRVars',
		'fsParams',
		'fsOut'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
FunSig class >> tVars: tVars rVars: rVars params: params out: out [
	^self basicNew
		fsTVars: tVars;
		fsRVars: rVars;
		fsParams: params;
		fsOut: out;
		yourself
]

{ #category : #accessing }
FunSig >> fsOut [
	^ fsOut
]

{ #category : #accessing }
FunSig >> fsOut: anObject [
	fsOut := anObject
]

{ #category : #accessing }
FunSig >> fsParams [
	^ fsParams
]

{ #category : #accessing }
FunSig >> fsParams: anObject [
	fsParams := anObject
]

{ #category : #accessing }
FunSig >> fsRVars [
	^ fsRVars
]

{ #category : #accessing }
FunSig >> fsRVars: anObject [
	fsRVars := anObject
]

{ #category : #accessing }
FunSig >> fsTVars [
	^ fsTVars
]

{ #category : #accessing }
FunSig >> fsTVars: anObject [
	fsTVars := anObject
]

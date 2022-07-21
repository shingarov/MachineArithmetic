Class {
	#name : #TCon,
	#superclass : #RType,
	#instVars : [
		'c',
		'ts',
		'r'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TCon class >> c: c ts: ts r: r [
	^self basicNew
		c: c; ts: ts; r: r; yourself
]

{ #category : #accessing }
TCon >> c [
	^ c
]

{ #category : #accessing }
TCon >> c: anObject [
	c := anObject
]

{ #category : #'as yet unclassified' }
TCon >> freeTVarsGo [
	^Set unionAll: (ts collect: #freeTVarsGo)
]

{ #category : #accessing }
TCon >> r [
	^ r
]

{ #category : #accessing }
TCon >> r: anObject [
	r := anObject
]

{ #category : #accessing }
TCon >> ts [
	^ ts
]

{ #category : #accessing }
TCon >> ts: anObject [
	ts := anObject
]

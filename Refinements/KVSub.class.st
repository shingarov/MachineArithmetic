Class {
	#name : #KVSub,
	#superclass : #Object,
	#instVars : [
		'vv',
		'sort',
		'kVar',
		'subst'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
KVSub class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
KVSub class >> vv: vv sort: sort kVar: kVar subst: subst [
	^self basicNew vv: vv; sort: sort; kVar: kVar; subst: subst; yourself
]

{ #category : #accessing }
KVSub >> kVar [
	^ kVar
]

{ #category : #accessing }
KVSub >> kVar: anObject [
	kVar := anObject
]

{ #category : #accessing }
KVSub >> sort [
	^ sort
]

{ #category : #accessing }
KVSub >> sort: anObject [
	sort := anObject
]

{ #category : #accessing }
KVSub >> subst [
	^ subst
]

{ #category : #accessing }
KVSub >> subst: anObject [
	subst := anObject
]

{ #category : #accessing }
KVSub >> vv [
	^ vv
]

{ #category : #accessing }
KVSub >> vv: anObject [
	vv := anObject
]

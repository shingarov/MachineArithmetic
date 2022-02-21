Class {
	#name : #SEnv,
	#superclass : #Object,
	#instVars : [
		'binds'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
SEnv class >> binds: binds [
	"cf.
	   newtype SEnv α = SE { seBinds :: M.HashMap Symbol α }
	 in Environments.hs"
	^self basicNew binds: binds; yourself
]

{ #category : #'instance creation' }
SEnv class >> new [
	self shouldNotImplement 
]

{ #category : #accessing }
SEnv >> binds [
	^ binds
]

{ #category : #accessing }
SEnv >> binds: anObject [
	binds := anObject
]

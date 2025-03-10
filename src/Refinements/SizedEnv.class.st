"
data SizedEnv a    = BE { _beSize  :: !Int
                        , beBinds :: !(BindMap a)
                        } deriving (Eq, Show, Functor, Foldable, Generic, Traversable)

Cf. Types/Environments.hs
"
Class {
	#name : #SizedEnv,
	#superclass : #Object,
	#instVars : [
		'_beSize',
		'beBinds'
	],
	#category : #'Refinements-Environments'
}

{ #category : #'private - instance creation' }
SizedEnv class >> new [
	self shouldNotImplement
]

{ #category : #'private - instance creation' }
SizedEnv class >> size: s binds: bs [
	^self basicNew
		_beSize: s;
		beBinds: bs;
		yourself
]

{ #category : #accessing }
SizedEnv >> _beSize [
	^ _beSize
]

{ #category : #accessing }
SizedEnv >> _beSize: anObject [
	_beSize := anObject
]

{ #category : #accessing }
SizedEnv >> beBinds [
	^ beBinds
]

{ #category : #accessing }
SizedEnv >> beBinds: anObject [
	beBinds := anObject
]

"
data EvalEnv = EvalEnv
  { evEnv      :: !SymEnv
  , evAccum    :: EvAccum
  , evFuel     :: FuelCount
  } deriving Show
cf. PLE.hs
"
Class {
	#name : #EvalEnvPLE,
	#superclass : #Object,
	#instVars : [
		'evEnv',
		'evAccum',
		'evFuel'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
EvalEnvPLE class >> fromSymEnv: aSymEnv [ 
	^self basicNew
		evEnv: aSymEnv;
		evAccum: EvAccum new;
		evFuel: #defaultFuel;
		yourself
]

{ #category : #accessing }
EvalEnvPLE >> evAccum [
	^ evAccum
]

{ #category : #accessing }
EvalEnvPLE >> evAccum: anObject [
	evAccum := anObject
]

{ #category : #accessing }
EvalEnvPLE >> evEnv [
	^ evEnv
]

{ #category : #accessing }
EvalEnvPLE >> evEnv: anObject [
	evEnv := anObject
]

{ #category : #accessing }
EvalEnvPLE >> evFuel [
	^ evFuel
]

{ #category : #accessing }
EvalEnvPLE >> evFuel: anObject [
	evFuel := anObject
]

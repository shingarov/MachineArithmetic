Class {
	#name : #SMTContext,
	#superclass : #Object,
	#instVars : [
		'ctxSymEnv',
		'z3'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
SMTContext class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
SMTContext class >> with: aSymEnv [ 
	^self basicNew initializeFromSymEnv: aSymEnv
]

{ #category : #'as yet unclassified' }
SMTContext >> bracket: aBlockClosure [ 
	^z3 bracket: aBlockClosure
]

{ #category : #'as yet unclassified' }
SMTContext >> declare: aSymEnv [
"
declare :: Context -> IO () -- SolveM ()
cf. Smt/Interface.hs
"
	| xts |
	
	^self "BOGUS... only for PLE investigation"
]

{ #category : #'as yet unclassified' }
SMTContext >> del [
	z3 del.
	z3 := nil
]

{ #category : #'as yet unclassified' }
SMTContext >> evalToSMT: e₁_e₂ [
	| e₁ e₂ |
	e₁ := e₁_e₂ key. e₂ := e₁_e₂ value.
	^e₁ === e₂
]

{ #category : #initialization }
SMTContext >> initializeFromSymEnv: aSymEnv [
	z3 := Z3Solver new.
	self declare: aSymEnv
]

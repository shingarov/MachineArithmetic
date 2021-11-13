Class {
	#name : #SInfo,
	#superclass : #HornInfo,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #logic }
SInfo >> kVars [
	^ws keys asSet
]

{ #category : #'as yet unclassified' }
SInfo >> kvarDomain: k [
	"Compute the domain of a kvar"
	^bs domain: (self wfc: k)
]

{ #category : #'as yet unclassified' }
SInfo >> newTopBind: x to: sr [ 
	| be_i be i |
	be_i := bs insertVar: x sort: sr top.
	be := be_i key.
	i  := be_i value.
	^i -> (self copy bs: be)
]

{ #category : #'as yet unclassified' }
SInfo >> remakeSubst: s kvar: k [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
SInfo >> remakeSubsts [
	"self remakeSubst: 's' kvar: 'k' "
	
	^self
]

{ #category : #'as yet unclassified' }
SInfo >> sanitize [
	self shouldBeImplemented.
]

{ #category : #logic }
SInfo >> solve [
	| fi si wkl s0 ks act |
	
	fi := self.
	si := SolverInfo basicNew initializeFrom: fi.
	
	wkl := si initWorklist.
	s0 := si sol.
	ks := si vars.
	act := [ :solverState | solverState solve_: self s0: s0 ks: ks wkl: wkl ].
	^si runSolverM: act
]

{ #category : #logic }
SInfo >> solverInfo [
	^SolverInfo from: self
]

{ #category : #logic }
SInfo >> symbolEnv [
	"Answer a SymEnv"
	"cf. Sanitize.hs"
	^SymEnv new "IMPLEMENT NOW!" 
]

{ #category : #'as yet unclassified' }
SInfo >> updateWfc: w [
	| oldIds newIds fi1 v t k v1 w11 tail su w1 fi11 |
	oldIds := w env indexes.
	oldIds isEmpty ifFalse: [ #accumBindsIfValid shouldBeImplemented ]. newIds := oldIds. fi1 := self.
	
	v := w rft first.
	t := w rft second.
	k := w rft third.
	v1 := v kArgSymbol: k.
	
	w11 := w copy
		env: (IBindEnv from: newIds);
		rft: {v1.t.k.};
		yourself	.
	
	tail := (self kvarDomain: k) collect: [ :x | x -> (x kArgSymbol: k) ].
	su := Dictionary newFromAssociations: {v->v1.}, tail.
	w1 := w11 updateWfCExpr: su.
	
	fi11 := (fi1 newTopBind: v1 to: t trueSortedReft) value.
	fi11 ws: (ws copy at: k put: w1; yourself).
	^fi11
]

{ #category : #'as yet unclassified' }
SInfo >> updateWfcs [
	^ws inject: self into: [ :sInfoSoFar :eachWfC | sInfoSoFar updateWfc: eachWfC ]
]

{ #category : #'as yet unclassified' }
SInfo >> wfcUniqify [
	^self remakeSubsts updateWfcs
]

{ #category : #'as yet unclassified' }
SInfo >> ws: wfDictionary [ 
	ws := wfDictionary.
	^self
]

"
type Metric = [F.Expr]                  -- ^ lexic.sequence of int-refinements
"
Class {
	#name : #TerminationMetric,
	#superclass : #Array,
	#type : #variable,
	#category : #SpriteLang
}

{ #category : #testing }
TerminationMetric >> isLet [
	^false
]

{ #category : #'as yet unclassified' }
TerminationMetric >> wfMetric: γ [
"
wfMetric :: F.SrcSpan -> Env -> Metric -> Bool
"
	^self allSatisfy: [ :e | e wfMetric: γ ]
]

{ #category : #'as yet unclassified' }
TerminationMetric >> wfr: ms [
"
Well-foundedness Refinement
wfr :: Metric -> Metric -> F.Expr
"
	| pO p r |
	self assert: self isEmpty not.
	self assert: ms isEmpty not.
	pO := self first. p := ms first.
	
	r := (self size = 1 and: [ms size = 1]) ifTrue: [
		POr of: {}
	] ifFalse: [ 
		| mO m |
		mO := self allButFirst. m := ms allButFirst.
		PAnd of: { p === pO . mO wfr: m }
	].

	^PAnd of: { p okMetric . p ⊲ pO | r }
]

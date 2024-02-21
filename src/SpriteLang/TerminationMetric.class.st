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

{ #category : #'α-renaming' }
TerminationMetric >> uniq2: α [
	^self collect:[:e|e uniq2: α]
]

{ #category : #'as yet unclassified' }
TerminationMetric >> wfMetric: γ [
"
wfMetric :: F.SrcSpan -> Env -> Metric -> Bool
"
	^self allSatisfy: [ :e | e wfExpr: γ sort: Int sort ]
]

{ #category : #'as yet unclassified' }
TerminationMetric >> wfr: ms [
"
Well-foundedness Refinement
wfr :: Metric -> Metric -> F.Expr
"
	self isEmpty ifTrue: [ self error ].
	ms isEmpty ifTrue: [ self error ].
	
	^(self size = 1 and: [ms size = 1]) ifTrue: [
		| pO p |
		pO := self first. p := ms first.
		PAnd of: { p nat . p < pO }
	] ifFalse: [
		| pO mO p m r |
		pO := self first. mO := self allButFirst. p := ms first. m := ms allButFirst.
		r := PAnd of: { p === pO . mO wfr: m }.
		PAnd of: { p nat . p < pO | r }
	]
]

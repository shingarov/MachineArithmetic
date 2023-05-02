"
type Metric = [F.Expr]                  -- ^ lexic.sequence of int-refinements
"
Class {
	#name : #TerminationMetric,
	#superclass : #Array,
	#type : #variable,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
TerminationMetric >> wfMetric: γ [
"
wfMetric :: F.SrcSpan -> Env -> Metric -> Bool
"
self halt.
	^self allSatisfy: [ :e | e wfExpr: γ sort: Int sort ]
]

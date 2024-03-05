Class {
	#name : #MetricExpression,
	#superclass : #Expr,
	#instVars : [
		'source'
	],
	#category : #'SpriteLang-Parsing'
}

{ #category : #'instance creation' }
MetricExpression class >> source: aString [
	^self basicNew
		source: aString;
		yourself
]

{ #category : #'as yet unclassified' }
MetricExpression >> < rhs [
	(rhs isKindOf: MetricExpression) ifFalse: [ self error ]. 
	^DecidableRefinement text: source, ' < ', rhs source
]

{ #category : #'theory symbols' }
MetricExpression >> === rhs [
	(rhs isKindOf: MetricExpression) ifFalse: [ self error ].
	^DecidableRefinement text: source, ' === ', rhs source
]

{ #category : #'as yet unclassified' }
MetricExpression >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	"BOGUS, code duplication with DecidableRefinement.
	This should be refactored, maybe MetricExpression should be a subclass.
	(and 'source' vs 'text' will be reconciled at that point)"
	^[anEvalEnv evaluate: self source]
		on: VariableNotDeclared do: vndBlock
]

{ #category : #'as yet unclassified' }
MetricExpression >> nat [
	^DecidableRefinement text: '0 <= ', source
]

{ #category : #printing }
MetricExpression >> printOn: aStream [
	aStream nextPut: $«.
	aStream nextPutAll: source.
	aStream nextPut: $».
	
]

{ #category : #accessing }
MetricExpression >> source [
	^ source
]

{ #category : #accessing }
MetricExpression >> source: anObject [
	source := anObject
]

{ #category : #'F.Subable' }
MetricExpression >> subst: su [
"JUST EXPERIMENTING, DO NOT MERGE"
	"^DelayedSubst subst: su in: self"
	| replacement |
	replacement := su at: source ifAbsent: [ ^self ].
	"in these experiments, replacement happens to be EVar"
	^self class source: replacement sym
]

{ #category : #'as yet unclassified' }
MetricExpression >> wfExpr: γ sort: t [
"
wfExpr :: F.SrcSpan -> Env -> F.Expr -> F.Sort -> Bool
"
	| v |
	v := self
		evaluateIn: (EvalEnv ofSorts: γ eSorts)
		ifUndeclared: [ ^false ]. "expected: we just haven't reached the fixpoint where n is put in γ "
	^v sort = Int sort

]

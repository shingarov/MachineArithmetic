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
"TOTALLY BOGUS, DO NOT MERGE"
	| sorts |
	sorts := γ eSorts.
	"(F.checkSortExpr sp (eSorts g) e == Just t )"
	
	^(sorts at: source ifAbsent: [ ^false ]) = t
]

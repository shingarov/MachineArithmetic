Class {
	#name : #MetricExpression,
	#superclass : #DecidableRefinement,
	#category : #'SpriteLang-Parsing'
}

{ #category : #'α-renaming' }
MetricExpression >> uniq2: α [
	| source′ |

	source′ := α at: source ifAbsent:[^self].
	^self class source: source′


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

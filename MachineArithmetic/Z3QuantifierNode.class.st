Class {
	#name : #Z3QuantifierNode,
	#superclass : #Bool,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3QuantifierNode class >> exists: vs body: expr [ 
	^self mkQuantifier: false vars: vs body: expr
]

{ #category : #'instance creation' }
Z3QuantifierNode class >> forAll: vs body: expr [ 
	^self mkQuantifier: true vars: vs body: expr
]

{ #category : #'instance creation' }
Z3QuantifierNode class >> lambda: vs body: expr [ 
	^Z3 mk_lambda_const: expr ctx
		_: vs size
		_: vs
		_: expr
]

{ #category : #'instance creation' }
Z3QuantifierNode class >> mkQuantifier: isForall vars: vs body: body [
	| numVars weight qid skid |
	numVars := vs size.
	numVars = 0 ifTrue: [^body].
	weight := 1.
	qid := Z3Symbol new.
	skid := Z3Symbol new.
	^Z3 mk_quantifier_const_ex: Z3Context current _: isForall _: weight _: qid _: skid
		_: numVars _: vs
		_: 0 _: Array new "pats"
		_: 0 _: Array new "no-pats"
		_: body
]

{ #category : #accessing }
Z3QuantifierNode >> body [
	"Answer the expression being quantified."
	^Z3 get_quantifier_body: ctx _: self
]

{ #category : #GT }
Z3QuantifierNode >> childrenForInspector [
	^{self body}
]

{ #category : #testing }
Z3QuantifierNode >> isExists [
	^ Z3 is_quantifier_exists: ctx _: self

]

{ #category : #testing }
Z3QuantifierNode >> isForAll [
	^ Z3 is_quantifier_forall: ctx _: self

]

{ #category : #testing }
Z3QuantifierNode >> isLambda [
	^Z3 is_lambda: ctx _: self
]

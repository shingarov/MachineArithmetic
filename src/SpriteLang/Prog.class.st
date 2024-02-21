Class {
	#name : #Prog,
	#superclass : #Object,
	#instVars : [
		'options',
		'quals',
		'meas',
		'expr',
		'data'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
Prog class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Prog class >> quals: quals meas: meas expr: expr data: data options: options [
	^self basicNew
		quals: quals; meas: meas; expr: expr; data: data; options: options;
		yourself
]

{ #category : #accessing }
Prog >> data [
	^ data
]

{ #category : #accessing }
Prog >> data: anObject [
	data := anObject
]

{ #category : #accessing }
Prog >> expr [
	^ expr
]

{ #category : #accessing }
Prog >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
Prog >> meas [
	^ meas
]

{ #category : #accessing }
Prog >> meas: anObject [
	meas := anObject
]

{ #category : #accessing }
Prog >> options [
	^ options
]

{ #category : #accessing }
Prog >> options: anObject [
	options := anObject
]

{ #category : #accessing }
Prog >> quals [
	^ quals
]

{ #category : #accessing }
Prog >> quals: anObject [
	quals := anObject
]

{ #category : #verification }
Prog >> solve [
	| vc |
	vc := [self vcgen] runReader: #checkTermination initialState: (self options includes: #'check-termination').
	^vc solve
]

{ #category : #verification }
Prog >> vcgen [
	| expr′ env expr′′ cstr query |

	expr′ := expr uniq.
	env := ΓContext empEnv: meas typs: data.
	expr′′ := expr′ elaborate: env.
	CGState reset.
	cstr := expr′′ check: env rtype: TInt instance bTrue.
	query := HornQuery new.
	cstr addToQuery: query.
	CGState current cgInfo cgiKVars do: [ :kVar | kVar addToQuery: query ].
	quals do: [ :q | q addToQuery: query ].
	query qCon: (Dictionary newFromAssociations: meas).	
	#(1 2 3) do: [ :j | query addPapp: j ].
	^query
]

Class {
	#name : #DataTypeParser,
	#superclass : #RefinementParser,
	#category : #'SpriteLang-Parsing'
}

{ #category : #accessing }
DataTypeParser >> cbind [
	^self upperId ==> [ :id | SpriteBind identifier: id ]
]

{ #category : #accessing }
DataTypeParser >> ctorP [
	^ self cbind,
	  (' ' asParser star, self funArg commaList) optional,
	  self ctorResP,
	  #newline asParser
	==> [ :x | Ctor
		bind: x first
		funArgs: (x second ifNil: [#()] ifNotNil: [:space_funArgs | space_funArgs second] )
		reft: x third ]
]

{ #category : #accessing }
DataTypeParser >> ctorResP [
"ctorResP :: FP.Parser (Maybe Reft)"
	^(' ' asParser star, '=>' asParser trim, self concReftB brackets) optional
	==> [ :x | x ifNil: [ nil ] ifNotNil: [ x last ] ]
]

{ #category : #accessing }
DataTypeParser >> ctorsP [
	^('  | ' asParser, self ctorP) star,
	'  ;' asParser, #newline asParser plus
	==> [ :x | x first collect: #last ]
]

{ #category : #grammar }
DataTypeParser >> start [
	^self typP
]

{ #category : #accessing }
DataTypeParser >> typArgs [
	^self tvar commaSeparated
]

{ #category : #accessing }
DataTypeParser >> typP [
	^'type ' asParser,                     "1"
	self lowerId,                          "2"
	self typArgs parens optional,          "3"
	refVar commaSeparated parens optional, "4"
	refTop,                                "5"
	' =' asParser, #newline asParser,      "6,7"
	self ctorsP                            "8"
	==> [ :x |
		| tc tvars rvars inv ctors |
		tc := x second.
		tvars := (x third  ifNil: [#()]) collect: #symbol.
		rvars :=  x fourth ifNil: [#()].
		inv := x fifth.
		ctors := x last.
		Data
			name: tc
			vars: tvars
			rvars: rvars
			ctors: (ctors collect: [ :eachCtor | eachCtor mkCtor: tc tvs: tvars rvs: rvars ])
			inv: inv ]
]

Class {
	#name : #Alt,
	#superclass : #Object,
	#instVars : [
		'daCon',
		'binds',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
Alt class >> daCon: daCon binds: binds expr: expr [
	^self basicNew
		daCon: daCon;
		binds: binds;
		expr: expr;
		yourself
]

{ #category : #accessing }
Alt >> binds [
	^ binds
]

{ #category : #accessing }
Alt >> binds: anObject [
	binds := anObject
]

{ #category : #'α-renaming' }
Alt >> collectαRenames: α [
	"Rename all binds in this Alt and return new αRenames with those
	 renames noted."
	
	^binds 
		inject: α 
		into: [ :renames :bind | renames extMap: bind id to: (renames makeUnique: bind id)].
	
]

{ #category : #accessing }
Alt >> daCon [
	^ daCon
]

{ #category : #accessing }
Alt >> daCon: anObject [
	daCon := anObject
]

{ #category : #'as yet unclassified' }
Alt >> elabAlt: Γ ident: y rtype: t [
	| unfolded e′ |
	unfolded := Γ unfoldEnv′: y daCon: daCon binds: binds.
	unfolded isNil ifTrue: [ self error: 'bad pattern match' ].
	e′ := expr elabC: unfolded rtype: t.
	^Alt
		daCon: daCon
		binds: binds
		expr: e′
]

{ #category : #accessing }
Alt >> expr [
	^ expr
]

{ #category : #accessing }
Alt >> expr: anObject [
	expr := anObject
]

{ #category : #GT }
Alt >> gtBind [
	^''

]

{ #category : #GT }
Alt >> gtChildren [
	^{ expr }
]

{ #category : #GT }
Alt >> gtExpr [
	^self

]

{ #category : #testing }
Alt >> isLet [
	^false
]

{ #category : #printing }
Alt >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #printing }
Alt >> spriteOn: aStream indent: level [
	"Print receiver on `aStream` as SpriteLang source"

	aStream next: level * 4 put: Character space.
	aStream nextPutAll: '| '; nextPutAll: daCon.
	binds notEmpty ifTrue:[
		aStream nextPut:$(.
		binds
			do:[:bind | aStream nextPutAll: bind id ]
			separatedBy: [ aStream nextPutAll: ', ' ].
		aStream nextPut:$)
	].
	aStream nextPutAll: ' => '.
	expr spriteOn: aStream indent: level + 1.
]

{ #category : #'α-renaming' }
Alt >> uniq2: α [
	^self class
		daCon: daCon
		binds: (binds collect: [ :each | each uniq2: α])
		expr: (expr uniq2: α)
]

Extension { #name : #Z3Node }

{ #category : #'*PLE' }
Z3Node >> notGuardedApps [
"
  -- | @notGuardedApps e@ yields all the subexpressions that are
  -- applications not under an if-then-else, lambda abstraction, type abstraction,
  -- type application, or quantifier.
"
	self isPNot ifTrue: [ ^self args first notGuardedApps ].
	self isPAtom ifTrue: [ ^self args first notGuardedApps, self args second notGuardedApps ].
	self isApp ifFalse: [ self shouldBeImplemented ].
	^self args collectAndCat: [ :each | each notGuardedApps ]
]

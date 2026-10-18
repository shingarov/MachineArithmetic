"
I am a ""generalized"" method, i.e. a method that can be installed in a MethodDictionary, but is not a CompiledMethod.  When method lookup finds such a method and the VM attempts to invoke it, it sends #run:with:in: to the generalized method.

(An alternative terminology would be to call CompiledMethod methods ""proper methods"", and ones like myself, ""improper methods"").

We see two circumstances that lead to immediate applicability of such improper methods in MachineArithmetic.

First, to be able to automatically interpret logical specifications such as the Gentzen-like rules we see in the comments in ΛExpression>>check:rtype: and similar.  In both MA and LH, such rules are implemented by the programmer in Smalltalk or Haskell, but in an ideal world the rules would be machine-executable.

A second, orthogonal dimension is the keys of method lookup.  In Smalltalk-80 they can only be Symbols, and once lookup finds a method, that method can only succeed.  LaLonde and Van Gulik show how this can be generalized to backtracking without modifying the Smalltalk-80 kernel; obviously, we can go further and lookup on arbitrary goals, as in R.Milner's ""Goal Theory"".
"
Class {
	#name : #ExampleMorphism,
	#superclass : #Object,
	#category : #'GeneralizedMethods-Tests'
}

{ #category : #'calypso compatibility' }
ExampleMorphism >> acceptVisitor: v [
"BOGUS: AST, really"
]

{ #category : #smalltalk }
ExampleMorphism >> ast [
	^self "for now"
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> astForStylingInCalypso [
	^self ast
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> calypsoEnvironmentType [
	^ClyMethod
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> compiledMethod [
	^self
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> containsHalt [
	^false
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> convertToCalypsoBrowserItem: aMorphism [ 
	| item |
	item := ClyBrowserItem named: aMorphism selector with: aMorphism.
	item addProperty: (ClyMethodDefinitionProperty of: aMorphism).
	^item
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> hasBreakpoint [
	^false
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> hasPragmaNamed: aString [ 
	^false
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> isDeprecated [
	^false
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> isExtension [
	^false
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> isFFIMethod [
	^false
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> isInstalled [
	self methodClass isNil ifTrue: [ ^false ].
	self selector    isNil ifTrue: [ ^false ].
	^(self methodClass
			compiledMethodAt: self selector
			ifAbsent: [ ^false ]) == self
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> isTaggedWith: t [ 
	^false
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> isTestMethod [
	^false
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> methodClass [
	^ObjectWithNonMethodMorphism
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> origin [
	^ObjectWithNonMethodMorphism
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> package [
	^ExampleMorphism package
]

{ #category : #lifecycle }
ExampleMorphism >> removeFromSystem [
	self methodClass removeSelector: self selector
]

{ #category : #meat }
ExampleMorphism >> run: sel with: args in: recvr [
	^'f'
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> selector [
	^#f
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> sendsAnySelectorOf: _ [
	^false
]

{ #category : #smalltalk }
ExampleMorphism >> sourceCode [
	^'Φ→Ψ'
]

{ #category : #'smalltalk-80' }
ExampleMorphism >> sourcePointer [
	^nil
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> tags [
	^#()
]

{ #category : #'calypso compatibility' }
ExampleMorphism >> usesUndeclares [
	^false
]

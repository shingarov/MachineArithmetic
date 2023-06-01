Extension { #name : #InstructionStreamTest }

{ #category : #'*MustBeBooleanMagic' }
InstructionStreamTest >> testStepThroughInAMethodWithMNUInMustBeBoolean [

	| initialContext aContext receiver suspendedProcess return |
	
	receiver := self classUnderTest new.
	suspendedProcess := [ receiver callingAMethodWithMustBeBooleanMNU ] forkAt: Processor activePriority + 1.

	initialContext := aContext := suspendedProcess suspendedContext.
	[ initialContext method = (self classUnderTest >> #callingAMethodWithMustBeBooleanMNU) ] 
		whileFalse: [ initialContext := initialContext sender].
	
	return := suspendedProcess stepToHome: initialContext.
	
	"Suspended process should stop in the exception"	
	self assert: return method equals: (self classUnderTest lookupSelector: #doesNotUnderstand:).
]

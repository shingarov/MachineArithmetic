Class {
	#name : #Uninterpreted,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'abstract algebra' }
Uninterpreted >> <= y [
	"TODO: Generalize to any MNU.
	 For now, this is a proof of concept, see L5 isort00.
	
	 There are times when we are interested in -- for example --
	 the arithmetic properties of #<= coming from the LIA theory.
	 However, at other times -- such as isort on (list 'a) --
	 we don't know what 'a>>#<= is and we don't care."
	| op |
	op := (Z3Symbol new
		mkFuncFrom: {self sort . y sort}
		to: Bool sort "BOGUS; how shall we know what <= returns?"
	) withName: '<='.
	
	^op value: self value: self

]

Extension { #name : #Z3Object }

{ #category : #'*MachineArithmetic' }
Z3Object >> ensureValidZ3Object [
    "This method is no-op if the object appears to be valid 
     (based on the pointer value). Othwewise, throw an error.

     If you encounter this during a test, maybe you want to do:
     Z3Context createGlobalContext
    "

    self isNull ifTrue: [ NullZ3Object object: self ].
    self isPoisoned ifTrue: [ PoisonedZ3Object object: self ].

]

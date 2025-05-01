Class {
	#name : #Z3String,
	#superclass : #Z3Node,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3String class >> mkString: aString [ 
	^Z3Context current mkString: aString
]

{ #category : #types }
Z3String class >> sort [
	^Z3Sort string
]

{ #category : #accessing }
Z3String >> getString [
	"Caveat programmator:
	 We do not begin to address the escaping issues in https://github.com/Z3Prover/z3/issues/2286"
	^Z3Context current getString: self
]

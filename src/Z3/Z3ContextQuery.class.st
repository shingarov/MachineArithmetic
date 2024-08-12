Class {
	#name : #Z3ContextQuery,
	#superclass : #Query,
	#category : #'Z3-Core'
}

{ #category : #'default values' }
Z3ContextQuery >> defaultResumeValue [
	"the default answer, if no one handles the query and the exception is resumed"

	^ Z3Context global
]

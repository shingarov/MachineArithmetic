Class {
	#name : #Query,
	#superclass : #Notification,
	#category : #'PreSmalltalks-Pharo'
}

{ #category : #answering }
Query class >> answer: value do: block [
	"Evaluate `block` answering `value` to queries made within the block.
	 Returns the value of `block`.

	 See `Query class >> #query`"

	^block on: self do: [:q | q resume: value ]


	"
	Query answer: 'kitty' do:[
		Transcript show: 'Hello ' , Query query , '!'; cr.
	]
	"
]

{ #category : #asking }
Query class >> query [
	"Raise the query. Return the answer or default value.

	 See `Query class >> #answer:do:` and `Query >> #defaultResumeValue`"

	^self signal


	"
	Query answer: 'world' do:[
		Transcript show: 'Hello ' , Query query , '!'; cr.
		1
	]
	"
]

{ #category : #accessing }
Query >> defaultAction [
	"The default action taken if the exception is signaled."

	^self defaultResumeValue
]

{ #category : #accessing }
Query >> defaultResumeValue [
	"Default answer to this query. This value is used if nobody
	 provided 'better' answer using `#answer:do:`.

   By default an error is raised. Subclasses may override this
   to provide a suitable default."

	self error: 'No suitable default answer!'
]

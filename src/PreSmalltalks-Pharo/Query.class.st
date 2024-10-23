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

	| ctx |

	"Control flow arrives here in case query's value is not supplied
	 anywhere in current call chain. This is also the case when code
	 is evaluated within debugger since debugger runs in its own thread,
	 separately from debugee.

	 This leads to confusing situation that one may get different results
	 from query when executed by debugee and when executed by evaluating code
	 in debugger.

	 To mitigate this, the code below tries to detect whether control flow
	 came here due to evaluating in code in debugger and if so, manually
	 walks debugee's stack to find query's value.

	 Dangerous hackery for sure.
	"

	ctx := thisContext findContextSuchThat: [ :c | c selector == #DoItIn: and:[ (c tempAt: 1) isContext ] ].
	ctx notNil ifTrue:[
		"`ctx` is the context of do-it method activation. The only parameter is
		  the (original, debugee's) context in which the do-it is evaluated.
		  Walk debugee's stack starting with that context and search for
		  handler providing query's value (if any).

		  Implementation note: one may be very tempted to do just

			    self signalIn: (ctx tempAt: 1)

		  Don't try! This may cause debugee's context to return and
	    leaves smalltalk environment in inconsistent weird state
	    where nothing work. This is why we do it 'manually'.
		 "

		| handler |

		handler := (ctx tempAt: 1) nextHandlerContext.
		[ handler notNil ] whileTrue:[
			(handler exceptionClass handles: self) ifTrue:[
				"We found the handler context. Evaluate handler
				 block for receiver (the query instance in debuffer
				 thread!)"
				handler exceptionHandlerBlock cull: self.
			].
			handler := handler nextHandlerContext.
		].
	].

	"Otherwise, return the query's default value."
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

{ #category : #asking }
Query >> query [
	"Raise the query. Return the answer or default value.
	 Defined for compatibility with Smalltalk/X."

	^self signal

	"
	Query answer: 'world' do:[
		Transcript show: 'Hello ' , Query new query , '!'; cr.
		1
	]
	"
]

Class {
	#name : #ApplicationTerm,
	#superclass : #TartagliaTerm,
	#instVars : [
		'message',
		'receiver'
	],
	#category : #CardanoTartaglia
}

{ #category : #'instance creation' }
ApplicationTerm class >> functor: f args: args [
	^args first perform: f withArguments: args allButFirst 

]

{ #category : #'instance creation' }
ApplicationTerm class >> representing: aMessage sentTo: aReceiver [
	^self basicNew message: aMessage; receiver: aReceiver 
]

{ #category : #accessing }
ApplicationTerm >> arguments [ 
	^{ receiver }, message arguments
]

{ #category : #accessing }
ApplicationTerm >> functor [
	^self message selector
]

{ #category : #accessing }
ApplicationTerm >> message [
	^ message
]

{ #category : #accessing }
ApplicationTerm >> message: anObject [
	message := anObject
]

{ #category : #accessing }
ApplicationTerm >> receiver [
	^ receiver
]

{ #category : #accessing }
ApplicationTerm >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
ApplicationTerm >> substCosas: anEnvironment [
	| r args |
	r := receiver substCosas: anEnvironment.
	args := message arguments collect: [ :a | a substCosas: anEnvironment ].
	^r perform: message selector withArguments: args
]

{ #category : #accessing }
ApplicationTerm >> variables [ 
	| s |
	s := Set new.
	(self arguments collect: #variables) do: [ :varsOfOneChild | s addAll: varsOfOneChild ].
	^s
	
	
]

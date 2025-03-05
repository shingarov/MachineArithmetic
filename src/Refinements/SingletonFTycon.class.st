Class {
	#name : #SingletonFTycon,
	#superclass : #FTycon,
	#category : #Refinements
}

{ #category : #comparing }
SingletonFTycon >> = rhs [
	"there is only one: the equivalence class of all instances of the class"
	^rhs class = self class
]

{ #category : #comparing }
SingletonFTycon >> hash [
	^self class hash
]

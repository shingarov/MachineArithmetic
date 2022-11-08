Class {
	#name : #SInfo1,
	#superclass : #SInfo,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SInfo1 >> elaborate: senv [
"
class Elaborate a where
  elaborate :: Located String -> SymEnv -> a -> a
Cf. SortCheck.hs
"
	^(self as: SInfo5)
		elaboratedVars: senv;
		elaborate	
]

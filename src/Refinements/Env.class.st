Class {
	#name : #Env,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #Refinements
}

{ #category : #elaboration }
Env >> checkSym: x [
"
checkSym :: Env -> Symbol -> CheckM Sort
"
	^x⋅self
		ifFound: #instantiate
		alts: #error
]

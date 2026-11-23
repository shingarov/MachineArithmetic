Class {
	#name : #PAppPrelude,
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #API }
PAppPrelude class >> pappCons [
	^#(1 2 3) collect: [ :j |
		| hcon |
		hcon := HCon papp: j.
		hcon symbol -> hcon sort
	]
]

{ #category : #API }
PAppPrelude class >> pappQualifiers [
	^#(1 2 3) collect: [ :j | Qualifier pappQual: j ]

]

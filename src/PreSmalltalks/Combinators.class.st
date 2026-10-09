Class {
	#name : #Combinators,
	#superclass : #SharedPool,
	#classVars : [
		'B',
		'C',
		'I',
		'K',
		'S',
		'Y'
	],
	#category : #PreSmalltalks
}

{ #category : #'class initialization' }
Combinators class >> initialize [
	K := [ :x :_ | x ].
	S := [ :f :g :x | f value: x value: (g value: x) ].
	B := [ :f :g :x | f value: (g value: x) ].
	C := [ :f :g :x | f value: x value: g ].
	I := [ :x | x ].
	Y := [ :f | f fix ] "NB the naïve transliteration from Haskell
			as [ :f | f value: (Y value: f) ] will just loop forever because
			it will first attempt to evaluate the inner (Y value: f) due to
			strict (applicative) order, whereas in Haskell it will only do it
			when f forces it."
]

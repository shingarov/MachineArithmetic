Extension { #name : #HornInfo }

{ #category : #'*PLE' }
HornInfo >> normalizeIn: sEnv [
"
instance Normalizable (GInfo c a) where
  normalize si = si {ae = normalize $ ae si}
Cf. PLE.hs
"
	^self copy
		ae: (ae normalizeIn: sEnv);
		yourself
]

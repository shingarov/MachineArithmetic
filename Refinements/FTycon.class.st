Class {
	#name : #FTycon,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'instance creation' }
FTycon class >> symbol: c [
"
symbolFTycon :: LocSymbol -> FTycon
symbolFTycon c = symbolNumInfoFTyCon c defNumInfo defRealInfo
"
	^TC basicNew
		sym: c;
		yourself
]

{ #category : #'type algebra' }
FTycon >> fAppTC: argSorts [
"
fAppTC :: FTycon -> [Sort] -> Sort
fAppTC = fApp . fTyconSort
"
	^self fTyconSort fApp: argSorts
]

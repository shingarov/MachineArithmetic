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
	"fAppTC :: FTycon -> [Sort] -> Sort"
	^self sort fApp: argSorts
]

{ #category : #'type algebra' }
FTycon >> sort [
"
fTyconSort :: FTycon -> Sort
fTyconSort c
  | c == intFTyCon  = FInt
  | c == realFTyCon = FReal
  | c == numFTyCon  = FNum
  | otherwise       = FTC c
"
	self subclassResponsibility
]

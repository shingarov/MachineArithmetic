Class {
	#name : #PUnknown,
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #convenience }
PUnknown class >> newECon [
	^ECon prim: self new
]

{ #category : #selfification }
PUnknown >> constTy [
	^TAll
		var: 'a'
		type: (TVar symbol: 'a') bTrue
]

{ #category : #printing }
PUnknown >> spriteOn: stream indent: level [
	stream nextPutAll: '□'
]

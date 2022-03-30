Class {
	#name : #TFun,
	#superclass : #RType,
	#instVars : [
		'x',
		's',
		't'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TFun class >> x: x s: s t: t [
	^self basicNew
		x: x; s: s; t: t; yourself 
]

{ #category : #printing }
TFun >> printOn: aStream [
	aStream
			nextPutAll: 'TFun ';
			nextPutAll: x;
			nextPutAll: ': '.
	s printOn: aStream.
	aStream nextPutAll: '=>'.
	t printOn: aStream.
	

]

{ #category : #accessing }
TFun >> s [
	^ s
]

{ #category : #accessing }
TFun >> s: anObject [
	s := anObject
]

{ #category : #'as yet unclassified' }
TFun >> subst1: toExpr for: fromVarName [ 
	^TFun
		x: x
		s: (s subst1: toExpr for: fromVarName)
		t: (t subst1: toExpr for: fromVarName)
]

{ #category : #accessing }
TFun >> t [
	^ t
]

{ #category : #accessing }
TFun >> t: anObject [
	t := anObject
]

{ #category : #accessing }
TFun >> x [
	^ x
]

{ #category : #accessing }
TFun >> x: anObject [
	x := anObject
]

{ #category : #'as yet unclassified' }
TFun >> ≺ [ rhs
"
[Sub-Fun]  
       
       (v::t) => q[w := v]
       -------------------
       b{v:p} <: b{w:q}
  
      s2 <: s1    x2:s2 |- t1[x1:=x2] <: t2 
      -------------------------------------
      x1:s1 -> t1 <: x2:s2 -> t2
"
	| x2 s2 t2 t1_ |
	x2 := rhs x. s2 := rhs s. t2 := rhs t.
	self shouldBeImplemented 
]

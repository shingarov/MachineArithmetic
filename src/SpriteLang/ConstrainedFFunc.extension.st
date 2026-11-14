Extension { #name : #ConstrainedFFunc }

{ #category : #'*SpriteLang' }
ConstrainedFFunc >> constTyApp: function [
	^(super constTyApp: function)
		tlBlock: typeLevelBlock
]

{ #category : #'*SpriteLang' }
ConstrainedFFunc >> tFunClass [
	^ConstrainedTFun
]

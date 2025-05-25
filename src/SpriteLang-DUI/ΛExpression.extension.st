Extension { #name : #'ΛExpression' }

{ #category : #'*SpriteLang-DUI' }
ΛExpression >> gtInspectorUnparseSpriteIn: composite [
	<gtInspectorPresentationOrder: 100>
	composite text
		title: 'Unparse';
		display: [ self unparseSprite ]
]

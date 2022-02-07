Extension { #name : #Graph }

{ #category : #'*DepthFirstSearch-GT' }
Graph class >> arrowShape [
	^[ :each | BlLineElement new
		border: (BlBorder paint: Color black);
		toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder 
						paint: Color black; build))  ]
]

{ #category : #'*DepthFirstSearch-GT' }
Graph class >> blSccElement [
		| element |
		element := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
			background: Color transparent;
			border: (BlBorder paint: Color red);
			padding: (BlInsets all: 5).
		element graph beChildrenContainer: #default.
		^element
]

{ #category : #'*DepthFirstSearch-GT' }
Graph >> gtLiveFor: aView [
	<gtView>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlTextElement new
				text: (self nodeAtVertex: x) gtDisplayString asRopedText;
				padding: (BlInsets all: 5);
				geometry: BlEllipseGeometry new ];
		with: self vertices.
	view edges
		shape: self class arrowShape;
	connect: self edges from: [ :ass | ass key ] to: [ :ass | ass value ].
	view layout grid.
	^ aView mondrian
		title: 'Shape';
		priority: 50;
		initialize: view
]

{ #category : #'*DepthFirstSearch-GT' }
Graph >> gtSCCFor: aView [
	<gtView>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :each | Graph gtSccElement ];
		with: self scc trees
		forEach: [ :scc | 
			view nodes
				shape: [ :x | BlTextElement new text: x asString asRopedText ];
				with: scc allNodes.
			view layout circle ].
	view edges
		shape: Graph arrowShape;
		connect: self edges
		from: [ :x | self nodeAtVertex: x key ]
		to: [ :x | self nodeAtVertex: x value ].
	view layout circle radius: 100.
	^ aView mondrian
		title: 'SCC';
		priority: 51;
		initialize: view
]

{ #category : #'*DepthFirstSearch-GT' }
Graph class >> gtSccElement [
	| el |
	el := GtWidthExpandingElement new.
    el
		layout: (BlGridLayout vertical cellSpacing: -1);
		padding: (BlInsets all: 1);
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent ];
		background: Color yellow;
		addChild: Graph blSccElement.
	^el
]

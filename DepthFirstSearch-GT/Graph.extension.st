Extension { #name : #Graph }

{ #category : #'*DepthFirstSearch-GT' }
Graph >> gtLiveFor: aView [
	<gtView>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlTextElement new
				text: x gtDisplayString asRopedText;
				padding: (BlInsets all: 5);
				geometry: BlEllipseGeometry new ];
		with: self vertices.
	view edges
		shape: [ :each |
			BlLineElement new
				border: (BlBorder paint: Color black);
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder 
						paint: Color black; build))  ];
	connect: self edges from: [ :ass | ass key ] to: [ :ass | ass value ].
	view layout grid.
	^ aView mondrian
		title: 'Shape';
		priority: 50;
		initialize: view
]

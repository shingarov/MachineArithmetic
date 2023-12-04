Extension { #name : #Rule }

{ #category : #'*Deduction-Pharo' }
Rule >> asTextMorph [
	| fontWidth premissMorphs premissText premissWidth conclusionMorph conclusionText conclusionWidth maxWidth hl hlWidth |
	fontWidth := 'xxxxxxxxxx' asTextMorph width / 10.
	premissMorphs := premisses collect: [ :eachPremiss | eachPremiss asTextMorph backgroundColor: Color white; yourself ].
	premissText := Text streamContents: [ :s | premissMorphs
			do: [ :each | each imageForm printOn: s ]
			separatedBy: [ s nextPutAll: '   ' ] ].
	
	conclusionMorph := conclusion asTextMorph backgroundColor: Color white; yourself.
	conclusionText := Text streamContents: [ :s | conclusionMorph imageForm printOn: s ].
	
	premissWidth := premissText asTextMorph width.
	conclusionWidth := conclusionText asTextMorph width.
	maxWidth := premissWidth max: conclusionWidth.
	
	hl := Text
			new: (maxWidth / fontWidth + 2.5) ceiling
			withAll: (Character codePoint: 16r23AF). "Horizontal Line Extension"
	hlWidth := hl asTextMorph width.
	
	^((Text "pad premiss to center"
				new: (hlWidth - premissWidth / 2 / fontWidth) rounded
				withAll: $ ),
		premissText,
		String cr asText,
		hl,
		('[', name, ']') asText,
		String cr asText,
		(Text "pad conclusion to center"
				new: (hlWidth - conclusionWidth / 2 / fontWidth) rounded
				withAll: $ ),
		conclusionText) asTextMorph backgroundColor: Color white; yourself
]

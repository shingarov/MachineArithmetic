Extension { #name : #FFunc }

{ #category : #'*SpriteLang' }
FFunc >> constTyApp: function [
	| argNumCell argName arg fx |
	argNumCell := Context readState: #argNumber.
	argName := 'theoryFunctionArg' varSubscript: argNumCell first.
	arg := EVar of: argName.
	argNumCell at: 1 put: argNumCell first+1.
	fx := EApp fun: function imm: arg.
	^TFun
			x: argName
			s: from sort2bTrue
			t: (to constTyApp: fx)
]

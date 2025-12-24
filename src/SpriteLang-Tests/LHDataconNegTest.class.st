Class {
	#name : #LHDataconNegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-LHProper'
}

{ #category : #tests }
LHDataconNegTest >> test_AdtPeano2 [
	self processString: '
type void =
  | Void
  ;

type influx =
  | Silly (goo:int)
  ;

⟦val bob : n:int => influx[v|v===(Silly∘(n+1))] => void⟧
let bob = (n, s) => { Void };

⟦val test : int => void⟧
let test = (n) => {
  let s = Silly(n);
  bob(n,s)
};
'

"

"
]

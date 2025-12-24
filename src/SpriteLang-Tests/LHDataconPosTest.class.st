Class {
	#name : #LHDataconPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-LHProper'
}

{ #category : #tests }
LHDataconPosTest >> test_AdtPeano2 [
	self processString: '
type void =
  | Void
  ;

type influx =
  | Silly (goo:int)
  ;

⟦val test : n:int => m:int => void[vv|(Silly∘n)===(Silly∘m)] => void[vv|n===m]⟧
let test = (n, m, z) => { Void };
'
]

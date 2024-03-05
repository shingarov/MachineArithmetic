Class {
	#name : #TerminationMetricTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
TerminationMetricTest >> test_nonrec [
	self proveSafe: '
[--check-termination]
⟦val fortyTwo : x:int => int[v|v === 42] / [0 toInt]⟧
let rec fortyTwo = (x) => {
  42
};
'
]

Class {
	#name : #FxSortTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FxSortTest >> ffunc1 [
	^NNFParser new funcSort parse: 
'(3 , [(P @(0) @(1) @(2));
       @(0);
       @(1);
       @(2);
       bool])'
"
FAbs
  0
  (FAbs
    1
    (FAbs
      2
      (FFunc
        (FApp
          (FApp
            (FApp
              (FTC (TC
                     'P'
                     (TCInfo {tc_isNum = False, tc_isReal = False, tc_isString = False})
                   )
              )
              (FVar 0))
            (FVar 1))
          (FVar 2))
        (FFunc
          (FVar 0)
          (FFunc
            (FVar 1)
            (FFunc
              (FVar 2)
              (FTC (TC
                     'bool'
                     (TCInfo {tc_isNum = False, tc_isReal = False, tc_isString = False}))
              )
            )
          )
        )
      )
    )
  )
"
]

{ #category : #tests }
FxSortTest >> testMkFFunc1 [
	| fabs ffunc fapp innermostFTC |
	fabs := self ffunc1.
	self assert: (fabs isKindOf: FAbs).
	"de-chucha 3 times"
	self assert: fabs int equals: 0.  fabs := fabs sort.
	self assert: fabs int equals: 1.  fabs := fabs sort.
	self assert: fabs int equals: 2.  ffunc := fabs sort.
	"inside the innermost FAbs, there is an FFunc going from an FApp to an FFunc"
	fapp := ffunc from.  ffunc := ffunc to.
	"the FApp is triple-nested applicaiton of the uninterpreted type constructor P to @0, @1, @2"
	innermostFTC := fapp s s s.
	self assert: innermostFTC typeConstructor sym equals: 'P'
]

{ #category : #tests }
FxSortTest >> testMkFFunc1FunctionSort [
	| vs_ss_s vs ss s |
	vs_ss_s := self ffunc1 functionSort.
	"Just ([0,1,2],
	       [FApp (FApp (FApp (FTC (TC 'P' (TCInfo {tc_isNum = False, tc_isReal = False, tc_isString = False}))) (FVar 0)) (FVar 1)) (FVar 2),
	        FVar 0,
	        FVar 1,
	        FVar 2],
	       FTC (TC 'bool' (TCInfo {tc_isNum = False, tc_isReal = False, tc_isString = False})))"
	vs := vs_ss_s first.  ss := vs_ss_s second.  s := vs_ss_s third.
	self assert: vs equals: #(0 1 2).
	self assert: ss size equals: 4.
	self assert: s equals: Z3Sort bool.
]

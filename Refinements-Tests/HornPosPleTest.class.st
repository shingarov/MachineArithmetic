Class {
	#name : #HornPosPleTest,
	#superclass : #HornTest,
	#category : #'Refinements-Tests'
}

{ #category : #'example programs' }
HornPosPleTest >> ple00 [
^'
(fixpoint "--rewrite")

(constant adder (func(0, [int, int, int])))

(define adder(x : int, y : int) : int = { x + y })

(constraint 
   (forall ((x int) (x == 5)) 
     (forall ((y int) (y == 6)) 
       (( (adder x y) = 11 ))
     )
   )
)
'
]

{ #category : #'example programs' }
HornPosPleTest >> pleList00 [
^'
(fixpoint "--rewrite")

(constant len (func(1, [(MyList  @(0)), int])))
(constant Cons (func(2, [@(0), (MyList  @(0)), (MyList @(0))])))
(constant Nil  (MyList @(0)))

(match len Nil = 0)
(match len Cons x xs = (1 + len xs))

(constraint
  (forall ((x int) (true))
    (forall ((y int) (y = 2)) 
      (forall ((z int) (z = 3)) 
        ((len (Cons x (Cons y (Cons z Nil))) = 3))
      )
    )
  )
)
'
]

{ #category : #'example programs' }
HornPosPleTest >> pleList01ADT [
^'
(fixpoint "--rewrite")
(fixpoint "--save")

(data Vec 1 = [
  | VNil  { }
  | VCons { head : @(0), tail : Vec @(0)}
])

(constant len (func(1, [(Vec @(0)), int])))

(define len(l: [a]) : int = {
  if (is$VNil l) then 0 else (1 + len(tail l))
})

(constraint
  (forall ((x int) (true))
    (forall ((y int) (y = 2)) 
      (forall ((z int) (z = 3)) 
        ((len (VCons x (VCons y (VCons z VNil))) = 3))
      )
    )
  )
)
'
]

{ #category : #'example programs' }
HornPosPleTest >> pleSum [
^'
(fixpoint "--rewrite")
(fixpoint "--save")

(constant sum  (func(0, [int, int])))

(define sum(n : int) : int = { if (n <= 0) then (0) else (n + sum (n-1)) })

(constraint 
   (forall ((x int) (x == 5)) 
       (( (sum x) = 15 ))
   )
)
'
]

{ #category : #'example programs' }
HornPosPleTest >> pleSumFuel5 [
^'
(fixpoint "--rewrite")
(fixpoint "--save")
(fixpoint "--fuel=6")

(constant sum  (func(0, [int, int])))

(define sum(n : int) : int = { if (n <= 0) then (0) else (n + sum (n-1)) })

(constraint 
   (forall ((x int) ((5 <= x) && (0 <= (sum (x-5))))) 
       ((15 <= (sum x)))
   )
)
'
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPLE0 [
	self skip.
	self provePos: self ple00
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleList00 [
	self skip.
	self provePos: self pleList00
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleList01ADT [
	self skip.
	self provePos: self pleList01ADT
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleSum [
	self skip.
	self provePos: self pleSum

]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleSumFuel5 [
	self skip.
	self provePos: self pleSumFuel5
]

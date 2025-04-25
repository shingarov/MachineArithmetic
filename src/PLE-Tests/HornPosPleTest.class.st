Class {
	#name : #HornPosPleTest,
	#superclass : #HornTest,
	#category : #'PLE-Tests'
}

{ #category : #'example programs' }
HornPosPleTest >> ple00 [
^'
(fixpoint "--rewrite")

(constant adder (func(0, [int;int;int])))

(define adder(x : int, y : int) : int = { x + y })

(constraint 
   (forall ((x int) (x === 5)) 
     (forall ((y int) (y === 6)) 
       (((adder value: x value: y) === 11 )))))
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
HornPosPleTest >> testL8poly [
self skip: 'Known Issue, #255'.
	self provePos: '
(fixpoint "--rewrite")
(var $k_1 ((`a) (`a) (`a)))
(constant cheq (func(1, [@(0); @(0); bool])))
(define cheq (x : `a,  y : `a) : bool = { x === y })
(constraint
 (and
  (forall ((x `a) (Bool true))
   (forall ((y `a) (Bool true))
    (and
      (forall ((VV `a) (VV === x))
        (($k_1 VV x y)))
      (forall ((VV `a) (VV === y))
        (($k_1 VV x y))))))
  (and
   (forall ((x int) (Bool true))
    (forall ((VV int) (VV === 0))
     ((cheq value: 2 value: 2))))
   (forall ((x int)  (Bool true))
     (forall ((VV int) (VV === 0))
      (((cheq value: Bool true value: Bool true))))))))
'
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPle0 [
	self provePos: self ple00
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPle42 [
	self provePos: '
(fixpoint "--rewrite")

(constant adder (func(0, [int;int])))

(define adder(x : int) : int = { 42 toInt })

(constraint 
   (forall ((x int) (Bool true)) 
      (((adder value: x) === 42))))
'
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleGauss [
	self provePos: '
(fixpoint "--rewrite")

(constant sum (func(0, [int;int])))

(define sum(m : int) : int = { m <= 0 ifThen: 0 toInt else: m + (sum value: m-1) })

(constraint
  (forall ((n int) (0 <= n))
     (forall ((base bool)  (base <=> (n <= 0)))
      (and
       (forall ((lq_tmp bool) (base))
         ((2 * (sum value: n) === (n * (n + 1)))))
       (forall ((lq_tmp bool) (base not))
         (forall ((n1 int)  (n1 === (n - 1)))
          (and
           (forall ((v int) (and (v === (n - 1)) (v === n1)))
            (and
             ((0 <= v))
             ((v < n))
             ((0 <= v))))
           (forall ((v int)  (2 * (sum value: n1) === (n1 * (n1 + 1))))
            (((2 * (sum value: n) === (n * (n + 1)))))))))))))
'
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleInc [
	self provePos: '
(fixpoint "--rewrite")

(constant inc (func(0, [int;int])))

(define inc(x : int) : int = { x+1 })

(constraint 
   (forall ((x int) (x===42)) 
      (((inc value: x) === 43))))
'
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
HornPosPleTest >> testPleSimpleIf [
	self provePos: '
(fixpoint "--rewrite")

(constant f (func(0, [int;int])))

(define f(n : int) : int = { n < 10 ifThen: 0 toInt else: 1 toInt })

(constraint 
   (forall ((x int) (x===15)) 
      (((f value: x) === 1))))
'
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleSum10 [
	self provePos: '
(fixpoint "--rewrite")

(constant sum (func(0, [int;int])))

(define sum(n : int) : int = { n <= 0 ifThen: 0 toInt else: sum∘(n-1) + n })

(constraint
  (forall ((x int) (x===10))
   ((sum∘x === 55))))
'
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleSum2 [
	self provePos: '
(fixpoint "--rewrite")

(constant sum (func(0, [int;int])))

(define sum(n : int) : int = { n <= 0 ifThen: 0 toInt else: sum∘(n-1) + n })

(constraint 
   ((sum∘2 === 3)))
'
]

{ #category : #'tests - safety' }
HornPosPleTest >> testPleSumFuel5 [
	self skip.
	self provePos: self pleSumFuel5
]

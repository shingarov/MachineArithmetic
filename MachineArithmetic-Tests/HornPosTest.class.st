Class {
	#name : #HornPosTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-Fixpoint'
}

{ #category : #'example programs' }
HornPosTest >> abs02re [
^'
(constraint 
  (and
      (forall ((x Int) (true))
       (forall ((VV Int) (VV == 10))
        ((VV >= 0))))
      (forall ((z Int) (true))
       (and
        (forall ((r Int) (r >= 0))
         (forall ((v Int) (v >= 0 && v == r))
          (((v >= 0)))))
        (forall ((_t1 Int) (_t1 >= 0))
         (forall ((v Int) (v >= 0))
          (((v >= 0)))))))))
'
]

{ #category : #'example programs' }
HornPosTest >> constant [
^'
(var $k0 ((Int)))

(qualif Foo ((v Int)) ((v > 100)))

(constraint 
  (forall ((x Int) (x > 0))
    (and
     (forall ((v Int) (v = f x))
      (($k0 v)))
      (forall ((z Int) ($k0 z))
       ((z = f x))))))

(constant f (func(0, [Int;Int])))
'
]

{ #category : #'example programs' }
HornPosTest >> ebind01 [
^'
(constraint
  (forall ((m Int) (true))
    (exists ((x1 Int) (true))
      (and
        (forall ((v Int) (v = m + 1)) ((v = x1)))
        (forall ((v Int) (v = x1 + 1)) ((v = 2 + m)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> ebind02 [
^'
(var $k ((Int)))

(constraint
  (forall ((m Int) (true))
    (forall ((z Int) (z = m - 1))
      (and
        (forall ((v1 Int) (v1 = z + 2)) (($k v1)))
        (exists ((x1 Int) (true))
          (and
            (forall ((v2 Int) ($k v2)) ((v2 = x1)))
            (forall ((v3 Int) (v3 = x1 + 1)) ((v3 = m + 2)))))))))
'
]

{ #category : #'example programs' }
HornPosTest >> ebind03 [
^'
(var $ka ((Int)))
(var $kb ((Int)))

(constraint
(and
 (exists ((x1 Int) (true))
  (and
   (forall ((v Int) (v = 1)) ((v = x1)))
   (forall ((v Int) (v = x1 + 1)) (($ka v)))))
 (exists ((x2 Int) (true))
  (and
   (forall ((v Int) ($ka v)) ((v = x2)))
   (forall ((v Int) (v = x2 + 1)) (($kb v)))))
 (forall ((v Int) ($kb v)) ((v = 3)))))
'
]

{ #category : #'example programs' }
HornPosTest >> icfp17ex1 [
^'
(fixpoint "--eliminate=horn")

(var $k ((Int)))

(constraint
  (forall ((x Int) (x >= 0))
    (and
      (forall ((v Int) (v = x - 1))
       (($k v)))
      (forall ((y Int) ($k y))
        (forall ((v Int) (v = y + 1))
          ((v >= 0)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> icfp17ex2 [
^'
(fixpoint "--eliminate=horn")

(var $kx ((Int)))
(var $ky ((Int)))

(constraint
  (forall ((x Int) (x >= 0))
    (and
      (forall ((n Int) (n = x - 1))
       (forall ((p Int) (p = x + 1))
         (and
           (forall ((v Int) (v = n)) (($kx v)))
           (forall ((v Int) (v = p)) (($ky v)))
           (forall ((v Int) ($kx p)) (($ky v))))))
      (forall ((y Int) ($ky y))
        (forall ((v Int) (v = y + 1))
          ((v >= 0)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> icfp17ex3 [
^'
(fixpoint "--eliminate=horn")

(var $ka ((Int)))
(var $kb ((Int)))
(var $kc ((Int)))

(constraint
 (and
  (forall ((a Int) ($ka a))
   (forall ((v Int) (v = a - 1)) (($kb v))))
  (forall ((b Int) ($kb b))
   (forall ((v Int) (v = b + 1))
    (($kc v))))
  (forall ((v Int) (v >= 0)) (($ka v)))
  (forall ((v Int) ($kc v)) ((v >= 0)))))
'
]

{ #category : #'example programs' }
HornPosTest >> ple00 [
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
HornPosTest >> pleList00 [
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
HornPosTest >> pleList01ADT [
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
HornPosTest >> pleSum [
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
HornPosTest >> pleSumFuel5 [
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
HornPosTest >> provePos: txt [
	| q |
	q := NNFParser parse: txt.
	self deny: q isPetitFailure.
	self assert: q solve equals: #Safe
	
]

{ #category : #'example programs' }
HornPosTest >> sumRec [
^'
(qualif Bar ((v Int)) (v >= 0))

(var $k_##1 ((Int) (Int)))

(constraint
  (and
      (forall ((n Int) (true))
       (forall ((cond bool) (cond <=> n <= 0))
        (and
         (forall ((lq_tmp$grd##4 bool) (cond))
          (forall ((VV int) (VV == 0))
           (($k_##1 VV n))))
         (forall ((lq_tmp$grd##4 bool) (not cond))
          (forall ((n1 int) (n1 == n - 1))
           (forall ((t1 int) ($k_##1 t1 n1))
            (forall ((v int) (v == n + t1))
             (($k_##1 v n1)))))))))
      (forall ((y int) (true))
       (forall ((r int) ($k_##1 r y))
        (forall ((ok1 bool) (ok1 <=> 0 <= r))
           (forall ((v bool) (and (v <=> 0 <= r) (v == ok1)))
            ((v)))))))) 


'
]

{ #category : #'example programs' }
HornPosTest >> sumRecOk [
^'
(qualif Bar ((v Int)) (v >= 0))

(var $k_##1 ((Int)))

(constraint
  (and
      (forall ((n int) (true))
       (forall ((cond bool) (cond <=> n <= 0))
        (and
         (forall ((lq_tmp$grd##4 bool) (cond))
          (forall ((VV int) (VV == 0))
           (($k_##1 VV))))
         (forall ((lq_tmp$grd##4 bool) (not cond))
          (forall ((n1 int) (n1 == n - 1))
           (forall ((t1 int) ($k_##1 t1))
            (forall ((v int) (v == n + t1))
             (($k_##1 v)))))))))
      (forall ((y int) (true))
       (forall ((r int) ($k_##1 r))
        (forall ((ok1 bool) (ok1 <=> 0 <= r))
           (forall ((v bool) (and (v <=> 0 <= r) (v == ok1)))
            ((v)))))))) 

'
]

{ #category : #'example programs' }
HornPosTest >> t00 [
^'
(fixpoint "--eliminate=horn")

(qualif  Foo ((v Int) (x Int)) (v = x))
(qualif  Bar ((v Int) (x Int)) (v > x))

(var $k1 ((Int) (Int) (Int)))
(var $k2 ((Int) (Int) (Int)))
(var $k3 ((Int) (Int) (Int)))

(constraint
  (forall ((x Int) (x > 0))
    (forall ((y Int) (y > x))
      (forall ((v Int) (v === (x + y))) 
         ((v > 0))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t000 [
^'
(fixpoint "--eliminate=horn")

(constraint
  (forall ((x Int) (x > 0))
    (forall ((y Int) (y > x))
      (forall ((v Int) (v === (x + y)))
         ((v > 0))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t01 [
^'
(fixpoint "--eliminate=horn")

(constraint 
  (forall ((x Int) (x > 0))
    (and
      (forall ((y Int) (y > x))
        (forall ((v Int) (v === (x + y)))
          ((v > 0))))
      (forall ((z Int) (z > 100))
        (forall ((v Int) (v === (x + z))) 
          ((v > 100)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t02 [
^'
(fixpoint "--eliminate=horn")

(var $k0 ((Int)))

(qualif Foo ((v Int)) ((v > 100)))

(constraint 
  (forall ((x Int) (x > 0))
    (and
      (forall ((y Int) (y > x + 100))
        (forall ((v Int) (v = x + y)) 
          (($k0 v))))
      (forall ((z Int) ($k0 z))
        (forall ((v Int) (v = x + z)) 
          ((v > 100)))))))
'
]

{ #category : #'example programs' }
HornPosTest >> t03 [
^'
(var $k0 ((Int)))

(qualif Foo ((v Int)) ((v > 0)))

(constraint 
  (and 
    (forall ((x Int) (x > 0))
      (forall ((v Int) (v = x)) 
        (($k0 v))))
    (forall ((y Int) ($k0 y))
      (forall ((v Int) (v = y + 1)) 
        (($k0 v))))
    (forall ((z Int) ($k0 z))
        ((z > 0)))))
'
]

{ #category : #'tests - safety' }
HornPosTest >> test00 [
	self provePos: self t00
]

{ #category : #'tests - safety' }
HornPosTest >> test000 [
	self provePos: self t000
]

{ #category : #'tests - safety' }
HornPosTest >> test01 [
	self provePos: self t01
]

{ #category : #'tests - safety' }
HornPosTest >> test02 [
	self provePos: self t02
]

{ #category : #'tests - safety' }
HornPosTest >> test03 [
	self provePos: self t03
]

{ #category : #'tests - safety' }
HornPosTest >> testAbs02re [
	self provePos: self abs02re
]

{ #category : #'tests - safety' }
HornPosTest >> testConstant [
	self provePos: self constant
]

{ #category : #'tests - safety' }
HornPosTest >> testEbind01 [
	self provePos: self ebind01
]

{ #category : #'tests - safety' }
HornPosTest >> testEbind02 [
	self provePos: self ebind02
]

{ #category : #'tests - safety' }
HornPosTest >> testEbind03 [
	self provePos: self ebind03
]

{ #category : #'tests - safety' }
HornPosTest >> testICFP17ex1 [
	self provePos: self icfp17ex1
]

{ #category : #'tests - safety' }
HornPosTest >> testICFP17ex2 [
	self provePos: self icfp17ex2
]

{ #category : #'tests - safety' }
HornPosTest >> testICFP17ex3 [
	self provePos: self icfp17ex3
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsEbind01 [
	| q |
	q := NNFParser parse: self ebind01.
	self assert: q qCstr first boundKVars equals: Set new
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsEbind02 [
	| q |
	q := NNFParser parse: self ebind02.
	self assert: q qCstr first boundKVars equals: (Set with: 'k')
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT00 [
	| q |
	q := NNFParser parse: self t00.
	self assert: q qCstr first boundKVars equals: Set new
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT01 [
	| q |
	q := NNFParser parse: self t01.
	self assert: q qCstr first boundKVars equals: Set new
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT02 [
	| q |
	q := NNFParser parse: self t02.
	self assert: q qCstr first boundKVars equals: (Set with: 'k0')
]

{ #category : #'tests - simple' }
HornPosTest >> testKVarsT03 [
	| q |
	q := NNFParser parse: self t03.
	self assert: q qCstr first boundKVars equals: (Set with: 'k0')
]

{ #category : #'tests - safety' }
HornPosTest >> testPLE0 [
	self provePos: self ple00
]

{ #category : #'tests - safety' }
HornPosTest >> testPleList00 [
	self provePos: self pleList00
]

{ #category : #'tests - safety' }
HornPosTest >> testPleList01ADT [
	self provePos: self pleList01ADT
]

{ #category : #'tests - safety' }
HornPosTest >> testPleSum [
	self provePos: self pleSum

]

{ #category : #'tests - safety' }
HornPosTest >> testPleSumFuel5 [
	self provePos: self pleSumFuel5
]

{ #category : #'tests - safety' }
HornPosTest >> testSumRec [
	self provePos: self sumRec
]

{ #category : #'tests - safety' }
HornPosTest >> testSumRecOk [
	self provePos: self sumRecOk
]

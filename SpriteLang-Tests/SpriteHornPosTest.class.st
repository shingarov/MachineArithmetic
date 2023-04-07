Class {
	#name : #SpriteHornPosTest,
	#superclass : #SpriteHornTest,
	#category : #'SpriteLang-Tests-Horn'
}

{ #category : #proving }
SpriteHornPosTest >> provePos: txt [
	self assert: (self verify: txt) equals: #Safe
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc00 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (and
    (and)
    (forall ((VV int) (VV === 10))
     ((Bool true))))
   (forall ((bar int) (bar === (10 + 1)))
    (and
     (and)
     (forall ((VV int) (VV === 0))
      ((Bool true))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc01 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (forall ((x int) (0 <= x))
    (and
     (and
      (and)
      (forall ((v int) (0 <= v))
       ((Bool true))))
     (forall ((tmp int) (tmp === (x + 1)))
      (and
       (and
        (and)
        (forall ((v int) (v === (x + 1)))
         ((Bool true))))
       (forall ((v int) (v === (tmp + 1)))
        (((0 <= v))))))))
   (and
    (and)
    (forall ((VV int) (VV === 0))
     ((Bool true)))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1inc02 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (Bool true))
       ((Bool true))))
     (forall ((VV int) (VV === 1))
      ((Bool true))))
    (forall ((v int) (v === (x + 1)))
     (((v === (x + 1)))))))
  (and
   (forall ((x int) (0 <= x))
    (and
     (and
      (and
       (and)
       (forall ((v int) (0 <= v))
        (((0 <= v)))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))
     (and
      (and
       (and)
       (and
        (forall ((v int) (0 <= v))
         ((Bool true)))
        (forall ((_xxx int) (0 <= _xxx))
         (forall ((v int) (v === (_xxx + 1)))
          (((0 <= v)))))))
      (forall ((v int) (0 <= v))
       (((0 <= v)))))))
   (and
    (and)
    (forall ((VV int) (VV === 0))
     ((Bool true)))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1int00 [
	self provePos: '
(constraint
 (and
  (and)
  (forall ((v1 Int) (v1 === 1))
   (and
    (and)
    (forall ((v2 Int) (v2 === 2))
     (and
      (and
       (and
        (and)
        (forall ((VV Int) (VV === 1))
         ((Bool true))))
       (forall ((VV Int) (VV === 2))
        ((Bool true))))
      (forall ((top Int) (top === (v1 + v2)))
       (and
        (and)
        (forall ((VV Int) (VV === 0))
         ((Bool true)))))))))))
'
]

{ #category : #'tests-L1' }
SpriteHornPosTest >> testL1int01 [
	self provePos: '
(constraint
 (and
  (and
   (and
    (and)
    (forall ((VV int) (VV === 1))
     ((Bool true))))
   (forall ((VV int) (VV === 1))
    ((Bool true))))
  (forall ((v1 int) (v1 === (1 + 1)))
   (and
    (and)
    (forall ((v2 int) (v2 === 2))
     (and
      (and
       (and
        (and
         (and)
         (forall ((v int) (v === (1 + 1)))
          ((Bool true))))
        (forall ((VV int) (VV === 2))
         ((Bool true))))
       (forall ((v int) (v === (v1 + v2)))
        (((v === 4)))))
      (forall ((top int) (top === 4))
       (and
        (and)
        (forall ((VV int) (VV === 0))
         ((Bool true)))))))))))
'
]

{ #category : #'tests-L2' }
SpriteHornPosTest >> testL2abs00 [
	self provePos: '
(constraint
 (and
  (forall ((x int) (Bool true))
   (and
    (and
     (and
      (and)
      (forall ((VV int) (VV === x))
       ((Bool true))))
     (forall ((VV int) (VV === 0))
      ((Bool true))))
    (forall ((pos bool) (pos <=> (x >= 0)))
     (and
      (forall ((lq_tmpßgrdºº2 bool) (pos))
       (and
        (and)
        (forall ((VV int) (VV === x))
         (((0 <= VV))))))
      (forall ((lq_tmpßgrdºº2 bool) (pos not))
       (and
        (and
         (and
          (and)
          (forall ((VV int) (VV === 0))
           ((Bool true))))
         (forall ((VV int) (VV === x))
          ((Bool true))))
        (forall ((v int) (v === (0 - x)))
         (((0 <= v))))))))))
  (and
   (and)
   (forall ((VV int) (VV === 0))
    ((Bool true))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3_squareIsNonnegative [
	self provePos: '
(var $k ((int) (int)))

(constraint
  (and
   (forall ((x int) (Bool true))
     (forall ((v int) (v === (x * x)))
      (($k v x))))
    (forall ((y int) (Bool true))
      (forall ((squared int) ($k squared y))
        (forall ((isPos bool) (isPos <=> (0 <= squared)))
          (forall ((b bool) (and (b <=> (0 <= squared)) (b === isPos)))
           ((b))))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01 [
	self provePos: '
(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (forall ((b bool) (b))
   (forall ((VV int) (VV === 0))
    (and)))
  (and
   (forall ((x int) (Bool true))
    (and
     (and
      (forall ((VV int) (and (Bool true) (VV === x)))
       (and))
      (forall ((VV int) (VV === 0))
       (and)))
     (forall ((pos bool) (pos <=> (x >= 0)))
      (and
       (forall ((lq_tmpßgrdºº3 bool) (pos))
        (forall ((VV int) (and (Bool true) (VV === x)))
         (($k_ºº1 VV x))))
       (forall ((lq_tmpßgrdºº3 bool) (pos not))
        (and
         (and
          (forall ((VV int) (VV === 0))
           (and))
          (forall ((VV int) (and (Bool true) (VV === x)))
           (and)))
         (forall ((v int) (v === (0 - x)))
          (($k_ºº1 v x)))))))))
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((VV int) (and (Bool true) (VV === y)))
       (and))
      (forall ((ya int) ($k_ºº1 ya y))
       (and
        (and
         (forall ((VV int) (VV === 0))
          (and))
         (forall ((VVºº0 int) (and ($k_ºº1 VVºº0 y) (VVºº0 === ya)))
          (and)))
        (forall ((ok bool) (ok <=> (0 <= ya)))
         (and
          (forall ((v bool) (and (v <=> (0 <= ya)) (v === ok)))
           ((v)))
          (forall ((VV int) (Bool true))
           (and))))))))
    (forall ((VV int) (VV === 0))
     (and))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01debug [
	self provePos: '
(var $k_ºº1 ((int) (int) (int)))

(constraint
 (and
  (forall ((b bool) (b))
   (forall ((VV int) (VV === 0))
    (and)))
  (and
   (forall ((x int) (Bool true))
    (forall ((VV int) (VV === 10))
     (((VV >= 0)))))
   (and
    (forall ((z int) (Bool true))
     (and
      (and
       (forall ((VV int) (and (Bool true) (VV === z)))
        (and))
       (forall ((r int) ($k_ºº1 r z z))
        (forall ((VVºº0 int) (and ($k_ºº1 VVºº0 z z) (VVºº0 === r)))
         (((VVºº0 >= 0))))))
      (and
       (and
        (forall ((VV int) (Bool true))
         (and))
        (forall ((y int) (Bool true))
         (forall ((v1 int) (v1 >= 0))
          (($k_ºº1 v1 z y)))))
       (forall ((v2 int) (v2 >= 0))
        (and)))))
    (forall ((VV int) (VV === 0))
     (and))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs01shorter [
	self provePos: '
(var $k_ºº1 ((int) (int)))

(constraint
  (and
   (forall ((x int) (Bool true))
     (forall ((pos bool) (pos <=> (x >= 0)))
      (and
       (forall ((lq_tmpßgrdºº3 bool) (pos))
        (forall ((VV int) (and (Bool true) (VV === x)))
         (($k_ºº1 VV x))))
       (forall ((lq_tmpßgrdºº3 bool) (pos not))
         (forall ((v int) (v === (0 - x)))
          (($k_ºº1 v x)))))))
    (forall ((y int) (Bool true))
      (forall ((ya int) ($k_ºº1 ya y))
        (forall ((ok bool) (ok <=> (0 <= ya)))
          (forall ((v bool) (and (v <=> (0 <= ya)) (v === ok)))
           ((v))))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3abs02debug [
	self provePos: '
(var $k ((int) (int) (int)))

(constraint
 (and
  (and
   (forall ((x int) (Bool true))
    (forall ((VV int) (VV === 10))
     (((VV >= 0)))))
    (forall ((z int) (Bool true))
     (and
      (and
       (forall ((r int) ($k r z z))
        (forall ((VVºº0 int) (and ($k VVºº0 z z) (VVºº0 === r)))
         (((VVºº0 >= 0))))))
        (forall ((y int) (Bool true))
         (forall ((v1 int) (v1 >= 0))
          (($k v1 z y)))))))))
'
]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3sum01 [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(qualif Geq ((v int) (n int)) (n <= v))

(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (and
   (forall ((n int) (Bool true))
    (and
     (forall ((cond bool) (cond <=> (n <= 0)))
      (and
       (forall ((lq_tmpßgrdºº4 bool) (cond))
        (forall ((VV int) (VV === 0)) 
         (($k_ºº1 VV n))))
       (forall ((lq_tmpßgrdºº4 bool) (cond not))
        (and
         (forall ((n1 int) (n1 === (n - 1)))
          (and
           (forall ((t1 int) ($k_ºº1 t1 n1))
            (and
             (forall ((v int) (v === (n + t1)))
              (($k_ºº1 v n))))))))))))) 
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((res int) ($k_ºº1 res y))
       (and
        (forall ((ok bool) (ok <=> (0 <= res)))
         (and
          (forall ((v bool) (and (v <=> (0 <= res)) (v === ok)))
           ((v))) 
           )))))))
    (and
     (forall ((y int) (Bool true))
      (and
       (forall ((res int) ($k_ºº1 res y))
        (and
         (forall ((ok bool) (ok <=> (y <= res)))
          (and
           (forall ((v bool) (and (v <=> (y <= res)) (v === ok)))
            ((v))) 
            ))))))))))
'

]

{ #category : #'tests-L3' }
SpriteHornPosTest >> testL3sum01α [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(qualif Geq ((v int) (n int)) (n <= v))

(var $k_ºº1 ((int) (int)))

(constraint
 (and
  (and
   (forall ((n int) (Bool true))
    (and
     (forall ((cond bool) (cond <=> (n <= 0)))
      (and
       (forall ((lq_tmpßgrdºº4 bool) (cond))
        (forall ((VV int) (VV === 0)) 
         (($k_ºº1 VV n))))
       (forall ((lq_tmpßgrdºº4 bool) (cond not))
        (and
         (forall ((n1 int) (n1 === (n - 1)))
          (and
           (forall ((t1 int) ($k_ºº1 t1 n1))
            (and
             (forall ((v int) (v === (n + t1)))
              (($k_ºº1 v n))))))))))))) 
   (and
    (forall ((y int) (Bool true))
     (and
      (forall ((res int) ($k_ºº1 res y))
       (and
        (forall ((ok bool) (ok <=> (0 <= res)))
         (and
          (forall ((w bool) (and (w <=> (0 <= res)) (w === ok)))
           ((w))) 
           )))))))
    (and
     (forall ((y int) (Bool true))
      (and
       (forall ((res int) ($k_ºº1 res y))
        (and
         (forall ((ok bool) (ok <=> (y <= res)))
          (and
           (forall ((w bool) (and (w <=> (y <= res)) (w === ok)))
            ((w))) 
            ))))))))))
'

]

{ #category : #'tests-L4' }
SpriteHornPosTest >> testL4foldn00 [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(var $k_ºº3 ((int) (int)))
(var $k_ºº1 ((`a) (bool) (int) (int) (`a) (`a) (int)))

(constraint
 (and
  (forall ((acc `a) (Bool true))
   (forall ((i int) (0 <= i))
    (forall ((n int) (i <= n))
     (and
      (forall ((leq bool) (leq <=> (i < n)))
       (and
        (forall ((lq_tmpßgrdºº6 bool) (leq))
         (and
          (forall ((ip int) (ip === (i + 1)))
           (and
             (forall ((v int) (and (0 <= v) (v === i)))
              (((0 <= v))))
            (forall ((accp `a) (Bool true))
             (and
              (and
               (and
                (and
                  (forall ((_ `a) (and ($k_ºº1 _ leq n ip accp acc i) (Bool true)))
                    (forall ((_ int) (0 <= _))
                     (forall ((VV `a) (Bool true))
                        (($k_ºº1 VV leq n ip accp acc i)))))
                 (forall ((VV `a)  (VV === accp))
                  (($k_ºº1 VV leq n ip accp acc i))))
                (forall ((v int) (and (v === (i + 1)) (v === ip)))
                 (((0 <= v)))))
               (forall ((v int) (and (i <= v) (v === n)))
                (((ip <= v)))))))))))))))))
  (and
   (forall ((x int) (Bool true))
    (forall ((y int) (Bool true))
      (forall ((v int) (v === (x + y)))
       (((v === (x + y)))))))
    (forall ((m int) (0 <= m))
     (and
      (and
       (and
        (and
          (forall ((_ int) (and ($k_ºº3 _ m) (Bool true)))
            (forall ((_ int) (0 <= _))
             (forall ((v int) (v === (_ + _)))
              (($k_ºº3 v m)))))
         (forall ((VV int) (VV === 0))
          (($k_ºº3 VV m))))
        (forall ((VV int) (VV === 0))
         (((0 <= VV)))))
       (forall ((v int) (and (0 <= v) (v === m)))
        (((0 <= v)))))
      (forall ((VVºº2 int) (and ($k_ºº3 VVºº2 m) (Bool true)))
       (((0 <= VVºº2)))))))))
'

]

{ #category : #'tests-L4' }
SpriteHornPosTest >> testL4id00 [
	self provePos: '
(var $k ((int) (int)))

(constraint
   (forall ((y int) (0 <= y))
    (and
     (forall ((v int) (and ((0 <= v)) ((v === y))))
        (($k v y)))
     (forall ((res int)  ($k res y))
      (forall ((z int) (and (and ($k z y) ((Bool true))) ((z === res))))
       ((0 <= z)))))))
'

]

{ #category : #'tests-L4' }
SpriteHornPosTest >> testL4id00s [
	self provePos: '
(var $k ((int) (int)))

(constraint
   (forall ((y int) (0 <= y))
    (and
     (forall ((v int) (and ((0 <= v)) ((v === y))))
        (($k v y)))
     (forall ((res int)  ($k res y))
      (forall ((VVºº0 int) (and ($k VVºº0 y) ((VVºº0 === res))))
       ((0 <= VVºº0)))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5MonoCons [
	"Like cons00 but with monomorphic (List Int)."
	self provePos: '
(var $k3 ((int) ((`l int)) (int)))
(var $k1 ((int) (int)))

(constant len (func(0 , [(`l int); int])))

(constraint
  (forall ((x int) (Bool true))
   (forall ((t (`l int)) ( (len value: t) === 0))
    (and
      (forall ((V int) (V === x))
       (($k3 V t x)))
       (forall ((VV int)  ($k1 VV x))
        (($k3 VV t x)))
      (forall ((v (`l int)) ((len value: v) === (1 + (len value: t))))
       ((((len value: v) === 1))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5append00 [
	self provePos: '
(var $k3 ((`a) ((`l `a)) ((`l `a)) ((`l `a)) (`a) ((`l `a))))
(var $k1 ((`a) ((`l `a)) ((`l `a)) ((`l `a)) (`a)))

(constant len (func(1 , [(`l @(0)); int])))

(constraint
  (forall ((xs (`l `a)) (Bool true))
   (forall ((ys (`l `a)) (Bool true))
    (and
     (forall ((xs (`l `a)) (((len value: xs) === 0)))
       (forall ((V (`l `a)) (V === ys)) ((((len value: V) === ((len value: xs) + (len value: ys)))))))
     (forall ((h `a) (Bool true))
      (forall ((t (`l `a)) (Bool true))
       (forall ((xs (`l `a)) (((len value: xs) === (1 + (len value: t)))))
        (and
         (and
          (and
           (forall ((VV `a) (Bool true))
            (($k1 VV xs t ys h))))
           (forall ((VV `a) (Bool true))
            (($k1 VV t t ys h))))
         (forall ((rest (`l `a)) ((len value: rest) === ((len value: t) + (len value: ys))))
          (and
           (and
            (forall ((VV `a) ((VV === h)))
             (($k3 VV xs t ys h rest)))
             (forall ((VV0 `a) ($k1 VV0 t t ys h))
              (($k3 VV0 xs t ys h rest))))
            (forall ((v (`l `a)) ((len value: v) === (1 + (len value: rest))))
             ((((len value: v) === ((len value: xs) + (len value: ys))))))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5appendInt [
	self provePos: '
(var $k ((Int) ((`l Int)) ((`l Int)) ((`l Int)) (Int) ((`l Int))))
(constant len (func(1 , [(`l @(0)); int])))
(constraint
  (forall ((xs (`l Int)) (Bool true))
   (forall ((ys (`l Int)) (Bool true))
    (and
     (forall ((xs (`l Int)) ((len value: xs) === 0))
       (forall ((VV (`l Int)) (VV === ys))
         ((((len value: xs) + (len value: ys) === (len value: VV))))))
     (forall ((h Int) (Bool true))
      (forall ((t (`l Int)) (Bool true))
       (forall ((xs (`l Int))  (1 + (len value: t) === (len value: xs)))
         (forall ((rest (`l Int)) ((len value: t) + (len value: ys) === (len value: rest)))
          (and
            (forall ((VV Int) (VV === h))
              (($k VV xs t ys h rest)))
            (forall ((VV Int) (Bool true))
              (($k VV xs t ys h rest)))
            (forall ((v (`l Int)) (1 + (len value: rest) === (len value: v)))
              ((((len value: xs) + (len value: ys) === (len value: v))))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5cons00 [
	self provePos: '
(var $k3 ((`a) ((`l `a)) (`a)))
(var $k1 ((`a) (`a)))

(constant len (func(1 , [(`l @(0)); int])))

(constraint
  (forall ((x `a) (Bool true))
   (forall ((t (`l `a)) ((len value: t) === 0))
     (and
      (forall ((VV `a) (VV === x))
       (($k3 VV t x)))
      (forall ((VV0 `a)  ($k1 VV0 x))
        (($k3 VV0 a x)))
      (forall ((v (`l `a)) ((len value: v) === (1 + (len value: t))))
       ((((len value: v) === 1))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5foldRight00 [
	self provePos: '
(var $k3 ((`b) ((`l `a)) ((`l `a)) (`b) (`a)))
(var $k1 ((`a) ((`l `a)) ((`l `a)) (`b) (`a)))

(constraint
  (forall ((b `b) (Bool true))
   (forall ((xs (`l `a)) (Bool true))
     (forall ((h `a) (Bool true))
      (forall ((t (`l `a)) (Bool true))
       (forall ((xs (`l `a)) (Bool true))
         (and
          (and
            (forall ((_ `a) (and ($k1 _ xs t b h) (Bool true)))
              (forall ((_ `b) (and ($k3 _ xs t b h) (Bool true)))
               (forall ((VV `b) (Bool true))
                (($k3 VV xs t b h)))))
           (forall ((VV `b) (VV === b))
            (($k3 VV xs t b h))))
           (forall ((VV `a) (Bool true))
            (($k1 VV xs t b h))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5head00 [
	self provePos: '
(var $k9 ((int) ((`l int)) (int)))
(var $k7 ((int) (int)))
(var $k5 ((`a) ((`l `a))))
(var $k3 ((`a) ((`l `a)) (`a)))
(var $k1 ((`a) (`a)))

(constraint
 (and
  (forall ((x `a) (Bool true))
   (forall ((t (`l `a)) (Bool true))
     (and
      (forall ((VV `a) (VV === x)) (($k3 VV t x)))
      (forall ((VV0 `a) ($k1 VV0 x)) (($k3 VV0 t x))))))
  (forall ((z int) (0 <= z))
     (and
      (forall ((v int) (and (0 <= v) (v === z))) (($k7 v z)))
      (forall ((l (`l int)) (Bool true))
       (and
        (forall ((VV6 int) ($k7 VV6 z))   (($k9 VV6 l z)))
        (forall ((VV8 int) ($k9 VV8 l z)) (((0 <= VV8))))))))))
'
]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5head01 [
	self provePos: '
(var $k9 ((int) ((`l int)) (int)))
(var $k7 ((int) (int)))
(var $k5 ((`a) ((`l `a)) (`a)))
(var $k3 ((`a) (`a)))
(var $k1 ((`a) ((`l `a))))

(constant len (func(1 , [(`l @(0)); int])))

(constraint
 (and
  (forall ((xs (`l `a)) ((len value: xs) > 0))
    (forall ((xs (`l `a)) (and ((len value: xs) > 0) ((len value: xs) === 0)))
      (forall ((VV int) (VV === 0)) ((Bool false)))))
  (and
   (forall ((x `a) (Bool true))
    (forall ((t (`l `a)) ((len value: t) === 0))
      (and
        (forall ((VV `a) (VV === x)) (($k5 VV t x)))
        (forall ((VV2 `a) ($k3 VV2 x)) (($k5 VV2 t x)))
        (forall ((v (`l `a)) ((len value: v) === (1 + (len value: t)))) ((((len value: v) === 1)))))))
    (forall ((z int) (Bool true))
     (and
      (forall ((VV int) (VV === z)) (($k7 VV z)))
      (forall ((l (`l int)) ((len value: l) === 1))
        (and
         (forall ((w (`l int)) (and ((len value: w) === 1) (w === l)))  ((((len value: w) > 0))))
         (forall ((VV6 int) ($k7 VV6 z))        (($k9 VV6 l z))))))))))
'
]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5isort00 [
	self provePos: '
(var $k19 ((`a) ((`l `a)) ((`l `a)) (`a) ((`l `a))))
(var $k17 ((`a) ((`l `a)) ((`l `a)) (`a)))
(var $k15 ((`a) ((`l `a))))
(var $k13 ((`a) (`a) ((`l `a)) ((`l `a)) (`a) ((`l `a)) (bool)))
(var $k11 ((`a) (`a) ((`l `a)) ((`l `a)) (`a) (bool)))
(var $k9 ((`a) (`a) ((`l `a)) ((`l `a)) (`a) ((`l `a)) (bool)))
(var $k7 ((`a) (`a) ((`l `a)) ((`l `a)) (`a) (bool)))
(var $k5 ((`a) (`a) ((`l `a)) ((`l `a)) (`a)))
(var $k3 ((`a) ((`l `a)) ((`l `a)) (`a)))
(var $k1 ((`a) ((`l `a)) (`a)))

(constant len (func(1 , [(`l @(0)); int])))

(constraint
 (and
  (forall ((x `a) (Bool true))
   (forall ((ys (`l `a)) (Bool true))
    (and
     (forall ((ys (`l `a)) ((len value: ys) === 0))
      (forall ((t (`l `a)) ((len value: t) === 0))
       (and
        (and
         (forall ((VV `a) (VV === x))
          (($k3 VV t ys x)))
         (and
          (forall ((VV0 `a) (and ($k1 VV0 ys x) (Bool true)))
           (($k3 VV0 t ys x)))))
        (and
         (forall ((v (`l `a)) ((len value: v) === (1 + (len value: t))))
          ((((len value: v) === (1 + (len value: ys))))))
         ))))
     (forall ((y0 `a) (Bool true))
      (forall ((ys1 (`l `a)) (Bool true))
       (forall ((ys (`l `a)) ((len value: ys) === (1 + (len value: ys1))))
        (and
         (and
          (forall ((VV `a) (VV === x))
           (($k5 VV y0 ys ys1 x)))
          (forall ((VV `a) (VV === y0))
           (($k5 VV y0 ys ys1 x))))
         (forall ((cmp bool) (cmp <=> (x <= y0)))
          (and
           (forall ((lq_tmp_grd7 bool) (cmp))
            (and
             (and
              (forall ((VV `a) (VV === y0))
               (($k7 VV y0 ys ys1 x cmp)))
              (and
               (forall ((VV `a) (Bool true))
                (($k7 VV y0 ys ys1 y0 cmp)))))
             (forall ((tl (`l `a)) ((len value: tl) === (1 + (len value: ys1))))
              (and
               (and
                (forall ((VV `a) (VV === x))
                 (($k9 VV y0 ys ys1 x tl cmp)))
                (and
                 (forall ((VV6 `a) (and ($k7 VV6 y0 ys ys1 y0 cmp) (Bool true)))
                  (($k9 VV6 y0 ys ys1 x tl cmp)))))
               (and
                (forall ((v (`l `a)) ((len value: v) === (1 + (len value: tl))))
                 ((((len value: v) === (1 + (len value: ys))))))
                )))))
           (forall ((lq_tmp_grd7 bool) (cmp not))
            (and
             (and
              (forall ((VV `a) (VV === x))
               (($k11 VV y0 ys ys1 x cmp)))
              (and
               (forall ((VV `a) (Bool true))
                (($k11 VV y0 ys ys1 x cmp)))))
             (forall ((tl (`l `a)) ((len value: tl) === (1 + (len value: ys1))))
              (and
               (and
                (forall ((VV `a) (VV === y0))
                 (($k13 VV y0 ys ys1 x tl cmp)))
                (and
                 (forall ((VV10 `a) (and ($k11 VV10 y0 ys1 ys1 x cmp) (Bool true)))
                  (($k13 VV10 y0 ys ys1 y0 tl cmp)))))
               (and
                (forall ((v (`l `a)) ((len value: v) === (1 + (len value: tl))))
                 ((((len value: v) === (1 + (len value: ys))))))))))))))))))))
  (and
   (forall ((xs (`l `a)) (Bool true))
    (and
     (forall ((xs (`l `a)) ((len value: xs) === 0))
      (and
       (forall ((v (`l `a)) ((len value: v) === 0))
        ((((len value: v) === (len value: xs)))))))
     (forall ((h `a) (Bool true))
      (forall ((t (`l `a)) (Bool true))
       (forall ((xs (`l `a)) ((len value: xs) === (1 + (len value: t))))
        (and
         (and
          (forall ((VV `a) (Bool true))
           (($k17 VV xs t h))))
         (forall ((ot (`l `a)) ((len value: ot) === (len value: t)))
          (and
           (and
            (forall ((VV `a) (VV === h))
             (($k19 VV xs t h ot))))
           (and
            (forall ((v (`l `a)) ((len value: v) === (1 + (len value: ot))))
             (((len value: v) === (len value: xs))))))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5isort01 [
	"Proving this relies on Z3's knowledge of the transitivity of <=.
	
	In LiquidHaskell this works because every sort monomorphizes to Z3 Int.
	In Smalltalk, 'a becomes Z3 Uninterpreted, so we need #mkLinearOrder:
	in Uninterpreted>>#<=.
	
	If we create an arbitrary uninterpreted relation instead,
	the following will not typecheck.
	However, if we change (`a) to Int, it will typecheck again. "

self provePos: '
(var $k6 ((`a) (`a) (`o) (`o) (`a)))
(var $k4 ((`a) (`a) (`o) (`o) (`a)))

(constraint
  (forall ((x `a) (Bool true))
   (forall ((ys `o) (Bool true))
     (forall ((y0 `a) (Bool true))
      (forall ((ys1 `o) (Bool true))
       (forall ((ys `o) (Bool true))
         (forall ((cmp bool) (cmp <=> (x <= y0)))
          (and
           (forall ((lq_tmp_grd7 bool) (cmp))
            (and
               (($k4 y0 y0 ys ys1 x))
               (forall ((VV `a) (y0 <= VV)) (($k4 VV y0 ys ys1 y0)))
               (forall ((VV6 `a) ($k4 VV6 y0 ys ys1 y0)) (((x <= VV6))))))
           (forall ((lq_tmp_grd7 bool) (cmp not))
            (and
             (($k6 x y0 ys ys1 x))
             (forall ((VV `a) (y0 <= VV)) (($k6 VV y0 ys ys1 x)))
             (forall ((VV10 `a) ($k6 VV10 y0 ys1 ys1 x)) ((y0 <= VV10)))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5nil00 [
	self provePos: '
(constant len (func(1 , [(`l @(0)); int])))

(constraint
  (forall ((x `a) (Bool true))
   (forall ((t (`l `a)) ((len value: t) === 0))
     (forall ((v (`l `a)) (((len value: v) === 0) & (v === t)))
      ((((len value: v) === 0)))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5olist00 [
	self provePos: '
(var $k ((int) (int) ((`o int))))

(constraint
 (and
  (forall ((apple int) (Bool true))
   (forall ((horse (`o int)) (Bool true))
    (and
     (and
      (forall ((VV int) (VV === apple))
       (($k VV apple horse)))
      (and
       (forall ((v int) (apple < v))
        (and
         (($k v apple horse))
         (((apple < v))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5olist01 [
	self provePos: '
(var $k_5 ((int) ((`o int)) ((`o int)) (int) (int) (int)))
(var $k_3 ((int) ((`o int)) (int) (int) (int)))
(var $k_1 ((int) (int) (int) (int)))

(constraint
  (forall ((n int) (Bool true))
   (forall ((n0 int) (n0 === n))
     (forall ((n1 int) (n1 === (n0 + 1)))
      (forall ((l2 (`o int)) (Bool true))
       (and
        (and
         (forall ((v int) ((v === (n0 + 1)) & (v === n1)))
          (($k_3 v l2 n0 n n1)))
          (forall ((VV0 int) (and ($k_1 VV0 n0 n n1) (Bool true)))
           (and
            (($k_3 VV0 l2 n0 n n1))
            (((n1 < VV0))))))
        (forall ((l1 (`o int)) (Bool true))
          (and
           (forall ((VV int) (and (VV === n) (VV === n0)))
            (($k_5 VV l1 l2 n0 n n1)))
           (forall ((VV2 int) (and ($k_3 VV2 l2 n0 n n1) (Bool true)))
             (and
              (($k_5 VV2 l1 l2 n0 n n1))
              (((n0 < VV2)))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5splitToOr00 [
	self provePos: '
(var $k5 ((int) (`i) (bool) (`i) (`i) (int)))
(var $k3 ((int) (`i) (`i) (`i) (int)))
(var $k1 ((int) (`i) (`i) (`i)))

(constant encoding (func(0 , [`i; int])))

(constraint
  (and
   (forall ((insn `i) (Bool true))
    (and
     (forall ((insn `i)  ((encoding value: insn) === 0))
      (forall ((VV int) (VV === 0))
       (($k1 VV insn A B))))
     (forall ((insn `i)  ((encoding value: insn) === 1))
      (forall ((VV int) (VV === 1))
       (($k1 VV insn A B))))))
    (forall ((insn `i) (Bool true))
      (forall ((e int) ($k1 e insn A B))
       (and
        (and
         (forall ((VV0 int) (and ($k1 VV0 insn A B) (VV0 === e)))
          (($k3 VV0 insn A B e)))
         (forall ((VV int) (VV === 0))
          (($k3 VV insn A B e))))
        (forall ((isZero bool) (isZero <=> (e === 0)))
         (and
          (and
           (forall ((VV0 int) (and ($k1 VV0 insn A B) (VV0 === e)))
            (($k5 VV0 insn isZero A B e)))
           (forall ((VV int) (VV === 1))
            (($k5 VV insn isZero A B e))))
          (forall ((isOne bool) (isOne <=> (e === 1)))
            (forall ((good bool) (good <=> (isZero | isOne)))
              (forall ((v bool) (and (v <=> (isZero | isOne)) (v === good)))
               ((v))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5tail01 [
	self provePos: '
(var $k (((`l `a)) ((`l `a))))

(constant len (func(1 , [(`l @(0)); int])))

(constraint
 (and
  (forall ((zs (`l `a)) ((len value: zs) > 0))
   (and
    (forall ((h `a) (Bool true))
     (forall ((t (`l `a)) (Bool true))
      (forall ((zs (`l `a)) (and ((len value: zs) > 0) ((len value: zs) === (1 + (len value: t)))))
        (forall ((VV (`l `a)) (VV === t)) ((((len value: VV) === ((len value: zs) - 1))))))))
    (forall ((zs (`l `a)) (and ((len value: zs) > 0) ((len value: zs) === 0)))
     (and
       (forall ((VV int) (VV === 0)) ((Bool false)))
       (forall ((VV2 (`l `a)) ($k VV2 zs)) ((((len value: VV2) === ((len value: zs) - 1)))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5tuple00 [
	self provePos: '
(var $k ((int) (int) (`c) (int) (int)))

(constraint
 (and
   (forall ((n int) (Bool true))
     (forall ((n1 int) (n1 === (n + 1)))
        (forall ((v int) (and (v === (n + 1)) (v === n1)))
         (((n < v))))))
    (forall ((m int) (Bool true))
      (forall ((p `c) (Bool true))
        (forall ((px int) (Bool true))
         (forall ((py int) (px < py))
          (forall ((p `c) (Bool true))
           (and
            (and
             (forall ((VV int) (VV === px))
              (($k VV m p px py)))
             (forall ((v int) (and (px < v) (v === py)))
              (($k v m p px py))))
            (forall ((ok bool) (ok <=> (px < py)))
              (forall ((v bool) (and (v <=> (px < py)) (v === ok))) ((v))))))))))))
'

]

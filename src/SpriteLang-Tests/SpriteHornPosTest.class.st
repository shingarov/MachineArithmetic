Class {
	#name : #SpriteHornPosTest,
	#superclass : #SpriteHornTest,
	#category : #'SpriteLang-Tests-Horn'
}

{ #category : #proving }
SpriteHornPosTest >> provePos: txt [
	self assert: (self verify: txt) isSafe
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
SpriteHornPosTest >> testL3sum01Q [
	self provePos: '
(qualif Pos ((v int)) (0 <= v))
(qualif Geq ((v int) (n int)) (n <= v))
(qualif PApp1 ((VV (@(0))) (p ((Pred @(0))))) (papp1 value: p value: VV))
(qualif PApp2 ((VV (@(1))) (x0 (@(0))) (p ((Pred @(0) @(1))))) (papp2 value: p value: x0 value: VV))
(qualif PApp3 ((VV (@(2))) (x0 (@(0))) (x1 (@(1))) (p ((Pred @(0) @(1) @(2))))) (papp3 value: p value: x0 value: x1 value: VV))

(var $k_ºº1 ((int) (int)))

(constant papp3 (func(3 , [(Pred @(0) @(1) @(2));
                           @(0);
                           @(1);
                           @(2);
                           bool])))
(constant papp2 (func(2 , [(Pred @(0) @(1)); @(0); @(1); bool])))
(constant papp1 (func(1 , [(Pred @(0)); @(0); bool])))

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
SpriteHornPosTest >> testL5cons00data [
	self provePos: '
(var $k3 ((`a) ((L `a)) (`a)))
(var $k1 ((`a) (`a)))

(constant len (func(1 , [(L @(0)); int])))

(data L 1 = [
        | Nil {}
        | Cons {Cons0 : @(0), Cons1 : (L @(0))}
      ])

(constraint
  (forall ((x `a) (Bool true))
   (forall ((t (L `a)) ((len value: t) === 0))
     (and
      (forall ((VV `a) (VV === x))
       (($k3 VV t x)))
      (forall ((VV0 `a)  ($k1 VV0 x))
        (($k3 VV0 a x)))
      (forall ((v (L `a)) ((len value: v) === (1 + (len value: t))))
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
SpriteHornPosTest >> testL5listSet [
	self provePos: '
(var $k3 ((`a) ((`l `a)) ((`l `a)) ((`l `a)) (`a) ((`l `a))))
(var $k1 ((`a) ((`l `a)) ((`l `a)) ((`l `a)) (`a)))

(constant elts (func(1 , [(`l @(0)); (Set_Set @(0))])))

(constraint
 (and
  (forall ((xs (`l `a)) (Bool true))
   (forall ((ys (`l `a)) (Bool true))
    (and
     (forall ((xs (`l `a)) ((elts value: xs) isEmptySet))
       (forall ((VV (`l `a)) (VV === ys))
        ((((elts value: VV) === ((elts value: xs) ∪ (elts value: ys)))))))
     (forall ((h `a) (Bool true))
      (forall ((t (`l `a)) (Bool true))
       (forall ((xs (`l `a)) ((elts value: xs) === ((elts value: t) add: h)))
        (and
         (forall ((VV `a) (Bool true)) (($k1 VV xs t ys h)))
         (forall ((VV `a) (Bool true)) (($k1 VV t t ys h)))
         (forall ((rest (`l `a)) ((elts value: rest) === ((elts value: t) ∪ (elts value: ys))))
          (and
            (forall ((VV `a) (VV === h)) (($k3 VV xs t ys h rest)))
            (forall ((VV0 `a) ($k1 VV0 t t ys h)) (($k3 VV0 xs t ys h rest)))
            (forall ((v (`l `a)) ((elts value: v) === ((elts value: rest) add: h)))
             ((((elts value: v) === ((elts value: xs) ∪ (elts value: ys)))))))))))))))))
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5nil00 [
	self provePos: '
(constant len (func(1 , [(`l @(0)); int])))

(constraint
  (forall ((x `a) (Bool true))
   (forall ((t (`l `a)) ((len value: t) === 0))
     (forall ((v (`l `a)) ((v === t)))
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
SpriteHornPosTest >> testL5tail01L8 [
	self provePos: '
(data L 1 = [
        | Nil {}
        | Cons {Cons0 : @(0), Cons1 : (L @(0))}
      ])

(constant len (func(1 , [(L @(0)); int])))

(constraint
  (forall ((h `a) (Bool true))
    (forall ((t (L `a)) (Bool true))
      (forall ((zs (L `a)) (and ((len value: zs) > 0)  ((len value: zs) === (1 + (len value: t)))))
        (forall ((VV (L `a)) (VV === t)) ((((len value: VV) === ((len value: zs) - 1)))))))))
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

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5tuple00L8 [
	self provePos: '
IMPLEMENT ME; the Fixpoint Doodle is already pushed.
'

]

{ #category : #'tests-L5' }
SpriteHornPosTest >> testL5tuple00L8poly [
	self provePos: '
(var $k1 ((int) (int) ((C int int)) (int) (int)))

(data C 2 = [
        | C {C0 : @(0), C1 : @(1)}
      ])

(constraint
  (and
    (forall ((n int) (Bool true))
      (forall ((n1 int) (n+1 === n1))
         (forall ((v int) ((n+1 === v) & (v === n1))) ((n < v)))))
    (forall ((m int) (Bool true))
      (forall ((p (C int int)) (Bool true))
        (forall ((px int)  (Bool true))
          (forall ((py int) (px < py))
           (forall ((p (C int int)) (Bool true))
            (and
              (forall ((VV int)  (VV === px)) (($k1 VV m p px py)))
              (forall ((v int) ((px < v) & (v === py))) (($k1 v m p px py)))
              (forall ((ok bool) (ok <=> (px < py)))
                (forall ((v bool) ((v <=> (px < py)) & (v === ok))) ((v))))))))))))
'

]

{ #category : #'tests-L6' }
SpriteHornPosTest >> testL6compose00 [
	self provePos: '
(qualif PApp2 ((VV (@(1))) (x0 (@(0))) (p ((Pred @(0) @(1))))) (papp2 value: p value: x0 value: VV))
(constant papp2 (func(2 , [(Pred @(0) @(1)); @(0); @(1); bool])))

(constraint
  (forall ((p (Pred `b `c)) (Bool true))
   (forall ((q (Pred `a `b)) (Bool true))
    (forall ((r (Pred `a `c)) (Bool true))
     (forall ((x `a) (Bool true))
       (forall ((t1 `b) (papp2 value: q value: x value: t1))
         (forall ((t2 `c) (papp2 value: p value: t1 value: t2))
          (and
           (and
            (forall ((v `b) (and (papp2 value: q value: x value: v) (v === t1)))
             (((papp2 value: q value: x value: v))))
            (forall ((v `c) (and (papp2 value: p value: t1 value: v) (v === t2)))
             (((papp2 value: p value: t1 value: v)))))
           (forall ((t3 Bool) (papp2 value: r value: x value: t2))
            (forall ((v `c) (and (papp2 value: p value: t1 value: v) (v === t2)))
             (((papp2 value: r value: x value: v)))))))))))))
'
]

{ #category : #'tests-L6' }
SpriteHornPosTest >> testL6deptup00 [
	self provePos: '
(var $k9 ((int) (int)))
(var $k8 ((int) (int) (int)))
(var $k6 ((int) (int) (int)))
(var $k4 ((int) (int)))
(var $k3 ((int) (int) (int)))
(var $k1 ((int) (int) (int)))

(constraint
 (and
  (forall ((x int) (Bool true))
    (forall ((y int)  (x + 1 === y))
     (and
      (and
       (forall ((VV int)  (VV === x))
         (($k1 VV x y)))
       (forall ((v int) (and  (x + 1 === v) (v === y)))
        (and
         (($k3 v x y))
         (($k4 x v)))))
        (forall ((rvTmp0 int) (Bool true))
         (forall ((rvTmp1 int)  ($k4 rvTmp0 rvTmp1))
          (((rvTmp0 < rvTmp1))))))))
   (forall ((x int)  (Bool true))
     (forall ((y int)  (x + 1 === y))
      (and
       (and
        (forall ((v int) (and (x + 1 === v) (v === y)))
          (($k6 v x y)))
        (forall ((VV int)  (VV === x))
         (and (($k8 VV y y)) (($k9 y VV)))))
         (forall ((rvTmp0 int) (Bool true))
          (forall ((rvTmp1 int)  ($k9 rvTmp0 rvTmp1))
           (((rvTmp0 > rvTmp1))))))))))
'
]

{ #category : #'tests-L6' }
SpriteHornPosTest >> testL6maxint [
	self provePos: '
(qualif PApp1 ((VV (@(0))) (p ((P @(0))))) (papp1 value: p value: VV))

(var $k3 ((int)))
(var $k2 ((int)))
(var $k1 ((int) ((P int)) (int) (int)))

(constant papp1 (func(1 , [(P @(0)); @(0); bool])))

(constraint
 (and
  (forall ((p (P int)) (Bool true))
   (forall ((x int)   (papp1 value: p value: x))
    (forall ((y int)   (papp1 value: p value: y))
     (and
      (forall ((v int) (and (papp1 value: p value: v) (v === x))) (($k1 v p x y)))
      (forall ((v int) (and (papp1 value: p value: v) (v === y))) (($k1 v p x y)))
      (forall ((b bool) (b <=> (x < y)))
       (and
        (forall ((g4 bool) (b))
         (forall ((v int) (and (papp1 value: p value: v) (v === y))) ((papp1 value: p value: v))))
        (forall ((g5 bool) (b not))
         (forall ((v int) (and (papp1 value: p value: v) (v === x))) ((papp1 value: p value: v))))))))))
  (and
   (forall ((a int)  (0 < a))
    (forall ((b int)  (0 < b))
     (and
       (forall ((v int) (and (0 < v) (v === a))) (($k2 v)))
       (forall ((v int) (and (0 < v) (v === b))) (($k2 v)))
       (forall ((v int) ($k2 v)) ((0 < v))))))
    (forall ((a int)  (a < 0))
     (forall ((b int)  (b < 0))
      (and
        (forall ((v int) (and (v < 0) (v === a))) (($k3 v)))
        (forall ((v int) (and (v < 0) (v === b))) (($k3 v)))
        (forall ((v int) ($k3 v)) ((v < 0)))))))))
'
]

{ #category : #'tests-L6' }
SpriteHornPosTest >> testL6maxintQ [
	self provePos: '
(qualif PApp1 ((VV (@(0))) (p ((P @(0))))) (papp1 value: p value: VV))
(qualif PApp2 ((VV (@(1))) (x0 (@(0))) (p ((P @(0) @(1))))) (papp2 value: p value: x0 value: VV))
(qualif PApp3 ((VV (@(2))) (x0 (@(0))) (x1 (@(1))) (p ((P @(0) @(1) @(2))))) (papp3 value: p value: x0 value: x1 value: VV))

(var $k3 ((int)))
(var $k2 ((int)))
(var $k1 ((int) ((P int)) (int) (int)))

(constant papp3 (func(3 , [(P @(0) @(1) @(2));
                           @(0);
                           @(1);
                           @(2);
                           bool])))
(constant papp2 (func(2 , [(P @(0) @(1)); @(0); @(1); bool])))
(constant papp1 (func(1 , [(P @(0)); @(0); bool])))

(constraint
 (and
  (forall ((p (P int)) (Bool true))
   (forall ((x int)   (papp1 value: p value: x))
    (forall ((y int)   (papp1 value: p value: y))
     (and
      (forall ((v int) (and (papp1 value: p value: v) (v === x))) (($k1 v p x y)))
      (forall ((v int) (and (papp1 value: p value: v) (v === y))) (($k1 v p x y)))
      (forall ((b bool) (b <=> (x < y)))
       (and
        (forall ((g4 bool) (b))
         (forall ((v int) (and (papp1 value: p value: v) (v === y))) ((papp1 value: p value: v))))
        (forall ((g5 bool) (b not))
         (forall ((v int) (and (papp1 value: p value: v) (v === x))) ((papp1 value: p value: v))))))))))
  (and
   (forall ((a int)  (0 < a))
    (forall ((b int)  (0 < b))
     (and
       (forall ((v int) (and (0 < v) (v === a))) (($k2 v)))
       (forall ((v int) (and (0 < v) (v === b))) (($k2 v)))
       (forall ((v int) ($k2 v)) ((0 < v))))))
    (forall ((a int)  (a < 0))
     (forall ((b int)  (b < 0))
      (and
        (forall ((v int) (and (v < 0) (v === a))) (($k3 v)))
        (forall ((v int) (and (v < 0) (v === b))) (($k3 v)))
        (forall ((v int) ($k3 v)) ((v < 0)))))))))
'
]

{ #category : #'tests-L6' }
SpriteHornPosTest >> testL6maxlist00 [
	self provePos: '
(qualif PApp1 ((VV (@(0))) (p ((Pred @(0))))) (papp1 value: p value: VV))
 
(var $k5 ((int)))
(var $k4 ((int)))
(var $k3 ((int)))
(var $k2 ((int)))
(var $k1 ((int) ((Pred int)) (int) (int)))
 
(constant papp1 (func(1 , [(Pred @(0)); @(0); bool])))
 
(constraint
 (and
  (forall ((p (Pred int)) (Bool true))
   (forall ((x int)  (papp1 value: p value: x))
    (forall ((y int)  (papp1 value: p value: y))
     (and
      (and
       (forall ((v int) (and  (papp1 value: p value: v) (v === x)))
        (and
         (($k1 v p x y))
         ))
       (forall ((v int) (and (papp1 value: p value: v) (v === y)))
         (($k1 v p x y))))
      (forall ((b bool)  (b <=> (x < y)))
       (and
        (forall ((grd4 bool) (b))
         (forall ((v int) (and (papp1 value: p value: v) (v === y)))
          (((papp1 value: p value: v)))))
        (forall ((grd4 bool) (b not))
         (forall ((v int) (and  (papp1 value: p value: v) (v === x)))
          (((papp1 value: p value: v)))))))))))
  (and
   (forall ((p (Pred int)) (Bool true))
    (forall ((cur int)  (papp1 value: p value: cur))
     (forall ((xs (`l int))  (Bool true))
      (and
       (forall ((h int)  (papp1 value: p value: h))
        (forall ((t (`l int)) (Bool true))
         (forall ((xs (`l int)) (Bool true))
          (and
           (and
            (forall ((v int) (and (papp1 value: p value: v) (v === cur)))
             (($k2 v)))
            (forall ((v int) (and (papp1 value: p value: v) (v === h)))
             (($k2 v))))
           (forall ((newCur int)  ($k2 newCur))
            (and
             (and
              (forall ((v int) (and  ($k2 v) (v === newCur)))
               (($k3 v)))
              (and
               (forall ((v int) (papp1 value: p value: v))
                (($k3 v)))))
             (forall ((v int)  ($k3 v))
              (((papp1 value: p value: v))))))))))
       (forall ((xs (`l int)) (Bool true))
        (forall ((v int) (and   (papp1 value: p value: v) (v === cur)))
         (((papp1 value: p value: v)))))))))
   (and
    (forall ((xs (`l int))  (Bool true))
     (and
      (and
       (forall ((VV int) (VV === 0))
        (($k4 VV)))
       (and
        (forall ((v int)  (0 <= v))
         (($k4 v)))))
      (forall ((v int) ($k4 v))
       (((0 <= v))))))
    (and
     (forall ((xs (`l int))  (Bool true))
      (and
       (and
        (forall ((VV int) (VV === 0))
         (($k5 VV)))
        (and
         (forall ((v int) (v <= 0))
          (($k5 v)))))
       (forall ((v int) ($k5 v))
        (((v <= 0)))))))))))

'
]

{ #category : #'tests-L6' }
SpriteHornPosTest >> testL6maxlist01 [
	self provePos: '
(qualif Geq ((v (int)) (n (int))) (n <= v))
(qualif AbsPred ((v (int)) (f (func(0 , [int; bool])))) (f value: v))
(qualif PApp1 ((VV (@(0))) (p ((Pred @(0))))) (papp1 value: p value: VV))

(var $k14 ((int)))
(var $k13 ((int)))
(var $k12 ((int) ((Pred int)) ((`l int))))
(var $k10 ((int) ((Pred int)) ((`l int)) ((`l int)) (int)))
(var $k8 ((int) ((Pred int)) ((`l int)) ((`l int)) (int)))
(var $k6 ((int)))
(var $k5 ((int) ((Pred int)) (int) (int)))
(var $k3 ((`b) ((`l `a)) ((`l `a)) (`b) (`a)))
(var $k1 ((`a) ((`l `a)) ((`l `a)) (`b) (`a)))

(constant papp1 (func(1 , [(Pred @(0)); @(0); bool])))

(constraint
 (and
  (forall ((b `b) (Bool true))
   (forall ((xs (`l `a)) (Bool true))
    (and
     (forall ((h `a)  (Bool true))
      (forall ((t (`l `a))  (Bool true))
       (forall ((xs (`l `a))  (Bool true))
        (and
         (and
          (and
           (and
            (forall ((xxxx `a)  ($k1 xxxx xs t b h))
             (and
              (forall ((xxx `b)  ($k3 xxx xs t b h))
               (forall ((VV `b)  (Bool true))
                 (($k3 VV xs t b h)))))))
           (forall ((VV `b)  (VV === b))
             (($k3 VV xs t b h))))
           (forall ((VV `a)  (Bool true))
             (($k1 VV xs t b h)))))))))))
  (and
   (forall ((p (Pred int)) (Bool true))
    (forall ((x int)  (papp1 value: p value: x))
     (forall ((y int)  (papp1 value: p value: y))
      (and
       (and
        (forall ((v int) ((papp1 value: p value: v) & (v === x)))
          (($k5 v p x y)))
        (forall ((v int) ((papp1 value: p value: v) & (v === y)))
          (($k5 v p x y))))
       (forall ((b bool) (b <=> (x < y)))
        (and
         (forall ((grd5 bool) (b))
          (forall ((v int) ((papp1 value: p value: v) & (v === y)))
           (((papp1 value: p value: v)))))
         (forall ((grd5 bool) (b not))
          (forall ((v int) ((papp1 value: p value: v) & (v === x)))
           (((papp1 value: p value: v)))))))))))
   (and
    (forall ((quxx (Pred int)) (Bool true))
     (forall ((xs (`l int))  (Bool true))
      (and
       (forall ((h int) (papp1 value: quxx value: h))
        (forall ((t (`l int))  (Bool true))
         (forall ((xs (`l int))  (Bool true))
          (and
           (and
            (and
             (and
              (forall ((VV7 int) ($k8 VV7 quxx xs t h))
               (($k6 VV7)))
              (forall ((xxxx int) ($k8 xxxx quxx xs t h))
               (and
                (forall ((VV9 int) ($k10 VV9 quxx xs t h))
                 (($k6 VV9)))
                (forall ((xxx int) ($k10 xxx quxx xs t h))
                 (forall ((v int) ($k6 v))
                   (($k10 v quxx xs t h)))))))
             (forall ((v int) ((papp1 value: quxx value: v) & (v === h)))
               (($k10 v quxx xs t h))))
            (and
             (forall ((v int)  (papp1 value: quxx value: v))
               (($k8 v quxx xs t h)))))
           (forall ((VV9 int) ($k10 VV9 quxx xs t h))
            (((papp1 value: quxx value: VV9))))))))
       (forall ((xs (`l int))  (Bool true))
        (and
         (forall ((VV11 int)  ($k12 VV11 quxx xs))
          ((papp1 value: quxx value: VV11))))))))
    (and
     (forall ((xs (`l int))  (Bool true))
      (and
       (and
        (forall ((v int) (0 <= v))
         (($k13 v))))
       (forall ((v int)  ($k13 v))
        (((0 <= v))))))
      (forall ((xs (`l int)) (Bool true))
       (and
        (forall ((v int) (v <= 0))
          (($k14 v)))
        (forall ((v int)  ($k14 v))
         (((v <= 0)))))))))))
'
]

{ #category : #'tests-L6' }
SpriteHornPosTest >> testL6maxpoly [
	self provePos: '
(qualif PApp1 ((VV (@(0))) (p ((Pred @(0))))) (papp1 value: p value: VV))
 
(var $k2 ((int)))
(var $k1 ((int) (int)))
 
(constant papp1 (func(1 , [(Pred @(0)); @(0); bool])))
 
(constraint
 (and
  (forall ((p (Pred `a)) (Bool true))
   (forall ((x `a) (papp1 value: p value: x))
    (forall ((v `a) (and (papp1 value: p value: v) (v === x)))
     ((papp1 value: p value: v)))))
  (and
   (forall ((apple int) (0 < apple))
    (and
     (forall ((v int) (and (0 < v) (v === apple)))
      (and
       (($k1 v apple))
       (($k2 v))))
     (forall ((VV0 int) (and ($k1 VV0 apple) ($k2 VV0)))
      (((0 < VV0)))))))))
'
]

{ #category : #'tests-L7' }
SpriteHornPosTest >> testL7sum [
	self provePos: '
(var $k ((int) (int)))
 
(constraint
 (and
  (forall ((n int) (Bool true))
   (and
    (and
     (forall ((VV int) (VV === n))
       (($k VV n)))
     (forall ((VV int) (VV === 0))
       (($k VV n))))
    (forall ((cond bool) (cond <=> (n <= 0)))
     (and
      (forall ((grd bool) (cond))
       (forall ((VV int) (VV === 0))
        (((0 <= VV)))))
      (forall ((grd bool) (cond not))
        (forall ((n1 int) (n1 === (n - 1)))
         (and
          (forall ((v int) (and (v === (n - 1)) (v === n1)))
            ((((0 <= v)
               & (v < n)))))
          (forall ((t1 int) (0 <= t1))
            (forall ((v int) (v === (n + t1)))
             (((0 <= v))))))))))))))

'
]

{ #category : #'tests-L7' }
SpriteHornPosTest >> testL7sumAcc [
	self provePos: '
(var $k ((int) (int) (int)))
 
(constraint
 (and
  (forall ((n int) (Bool true))
   (forall ((total int) (Bool true))
    (and
     (and
      (forall ((VV int)  (VV === n))
        (($k VV n total)))
      (forall ((VV int) (VV === 0))
        (($k VV n total))))
     (forall ((cond bool) (cond <=> (n <= 0)))
       (forall ((grd bool) (cond not))
         (forall ((n1 int) (n1 === (n - 1)))
           (forall ((tot1 int) (tot1 === (total + n)))
              (forall ((v int) (and (v === (n - 1)) (v === n1)))
                (((0 <= v
                   & (v < n))))))))))))))
'
]

{ #category : #'tests-L8' }
SpriteHornPosTest >> testL8uniqueVoid [
	"Cf. liquid-fixpoint/doodles/L8uniqueVoid.smt2 on branch experiment-z3datatypes"
	self provePos: '
(data V 0 = [
        | Nil {}
      ])
 
(constraint
    (forall ((a V) (Bool true))
      (forall ((b V) (Bool true))
          ((a === b)))))
'
]

{ #category : #'tests-L8' }
SpriteHornPosTest >> testL8uniqueVoidExplicitDistinction [
	self provePos: '
(data V 0 = [
        | One {}
        | Two {}
      ])
 
(constraint
    (forall ((a V) (a === One))
      (forall ((b V) (b === One))
          ((a === b)))))
'
]

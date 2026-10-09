"
Fritz Ruehr's ""The Evolution of a Haskell Programmer"" from
https://people.willamette.edu/~fruehr/haskell/evolution.html

This TestCase is part of the Functional Smalltalk discussion.

While I think the intent of Fritz's tutorial is a mix of didactic and
hilarious — and taking the functional nature of Haskell as given /
invariant / constant — this TestCase has more of a relative emphasis:
which functional idioms map naturally to Smalltalk, and which don't?
What changes to Smalltalk syntax, VM, and library would be required
for these mappings to work (and be pleasant to the programmer)?

It turns out that some constructs in Fritz's collection work in off-the-shelf
Pharo; some others need compatible changes to the library — most notably,
support for auto-currying.  (By ""compatible"" I mean they don't break the rest
of the Pharo image).

Other yet, expose VM bugs which are such even in regular Smalltalk —
regardless fuctional or not.

Others yet, slightly benefit from (but still work without) syntax extensions
such as ""sectioning"".  Some extensions I wish I had: in practice, many places
in the Smalltalk-25 codebase would read more comfortably if Smalltalk had
Destructuring (cf. test_Iterative).

Finally, two differences turn out fundamental (see tests marked with #skip):

1. Smalltalk doesn't consciously explicae the algebraic nature of data.

2. We don't have streams and other constructs benefiting from lazy evaluation.
(So we can't say `[1..]` in test_Memoizing, which is very sad).
I am convinced Martin Kobetic's XStreams would help; alas they never made it
into the standard library.
"
Class {
	#name : #FritzRuehrTest,
	#superclass : #TestCase,
	#instVars : [
		'fac'
	],
	#pools : [
		'Combinators'
	],
	#category : #'MathNotation-Tests'
}

{ #category : #running }
FritzRuehrTest >> assertGood [
	self
		assert: (fac value: 10)
		equals: 10 factorial
]

{ #category : #tests }
FritzRuehrTest >> test_Accumulating [
"
Accumulating Haskell programmer
(building up to a quick climax)

facAcc a 0 = a
facAcc a n = facAcc (n*a) (n-1)

fac = facAcc 1

"
	| facAcc |
	facAcc := [ :a :n |
		n = 0 ifTrue: [ ^a ].
		facAcc value: n*a value: n-1
	].
	
	fac := facAcc∘1.

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_AnotherJunior [
"
Another junior Haskell programmer
(read that n+k patterns are “a disgusting part of Haskell” [1]
and joined the “Ban n+k patterns”-movement [2])

fac 0 = 1
fac n = n * fac (n-1)
"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_AnotherSenior [
"
Another senior Haskell programmer
fac n = foldl (*) 1 [1..n]
"
	fac := [ :n |
		(1 to: n) foldl: #* fromSeed: 1
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_BeginningGraduate [
"
Beginning graduate Haskell programmer
(graduate education tends to liberate one from petty concerns
about, e.g., the efficiency of hardware-based integers)

-- the natural numbers, a la Peano

data Nat = Zero | Succ Nat


-- iteration and some applications

iter z s  Zero    = z
iter z s (Succ n) = s (iter z s n)

plus n = iter n     Succ
mult n = iter Zero (plus n)


-- primitive recursion

primrec z s  Zero    = z
primrec z s (Succ n) = s n (primrec z s n)


-- two versions of factorial

fac  = snd . iter (one, one) (\(a,b) -> (Succ a, mult a b))
fac' = primrec one (mult . Succ)


-- for convenience and testing (try e.g. 'fac five')

int = iter 0 (1+)

instance Show Nat where
  show = show . int

(zero : one : two : three : four : five : _) = iterate Succ Zero

"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_BoyScout [
"
Boy Scout Haskell programmer
(likes tying knots; always “reverent,” he
belongs to the Church of the Least Fixed-Point [8])

y f = f (y f)
fac = y (\f n -> if (n==0) then 1 else n * f (n-1))
"
	fac := Y value: [ :f :n |
		n=0
			ifTrue: [ 1 ]
			ifFalse: [ n * (f value: n-1) ]
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_BoyScout_curried [
"
Boy Scout Haskell programmer
(likes tying knots; always “reverent,” he
belongs to the Church of the Least Fixed-Point [8])

y f = f (y f)
fac = y (\f n -> if (n==0) then 1 else n * f (n-1))
"
	fac := Y value: [ :f | [:n |
		n=0
			ifTrue: [ 1 ]
			ifFalse: [ n * (f value: n-1) ]
	]].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Cartesian [
"
Cartesianally-inclined Haskell programmer
(prefers Greek food, avoids the spicy Indian stuff;
inspired by Lex Augusteijn’s “Sorting Morphisms” [3])

-- (product-based, list) catamorphisms and an application

cata (n,c) []     = n
cata (n,c) (x:xs) = c (x, cata (n,c) xs)

mult = uncurry (*)
prod = cata (1, mult)


-- (co-product-based, list) anamorphisms and an application

ana f = either (const []) (cons . pair (id, ana f)) . f

cons = uncurry (:)

downfrom = ana uncount

uncount 0 = Left  ()
uncount n = Right (n, n-1)


-- two variations on list hylomorphisms

hylo  f  g    = cata g . ana f

hylo' f (n,c) = either (const n) (c . pair (id, hylo' f (c,n))) . f

pair (f,g) (x,y) = (f x, g y)


-- several versions of factorial, all (extensionally) equivalent

fac   = prod . downfrom
fac'  = hylo  uncount (1, mult)
fac'' = hylo' uncount (1, mult)
"

	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_Combinatory [
"
Combinatory Haskell programmer
(eschews variables, if not obfuscation;
all this currying’s just a phase, though it seldom hinders)

cond p f g x = if p x then f x else g x
fac  = y (b (cond ((==) 0) (k 1)) (b (s (*)) (c b pred)))
"
	| cond |
	cond := [ :p :f :g :x | (p value: x) ifTrue: [f value: x] ifFalse: [g value: x] ].
	
	fac := Y value: (B
			value: (cond value: (□=0) value: (K value: 1))
			value: (B value: (S value: [ :x :y | x*y ]) value: (C value: B value: (□-1)))).

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_ContinuationPassing [
"
Continuation-passing Haskell programmer
(raised RABBITS in early years, then moved to New Jersey)

facCps k 0 = k 1
facCps k n = facCps (k . (n *)) (n-1)

fac = facCps id
"
	| facCps |
	facCps := [ :k :n |
		n = 0 ifTrue: [ ^k∘1 ].
		facCps value: k∘(n*□) value: n-1
	].
	
	fac := facCps value: #yourself.

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Freshman [
"
Freshman Haskell programmer

fac n = if n == 0 
           then 1
           else n * fac (n-1)
"
	fac := [ :n |
		n=0
			ifTrue: [1]
			ifFalse: [ n * (fac value: n-1) ]
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Interpretive [
"
Interpretive Haskell programmer
(never “met a language” he didn't like)

-- a dynamically-typed term language

data Term = Occ Var
          | Use Prim
          | Lit Integer
          | App Term Term
          | Abs Var  Term
          | Rec Var  Term

type Var  = String
type Prim = String


-- a domain of values, including functions

data Value = Num  Integer
           | Bool Bool
           | Fun (Value -> Value)

instance Show Value where
  show (Num  n) = show n
  show (Bool b) = show b
  show (Fun  _) = “”

prjFun (Fun f) = f
prjFun  _      = error “bad function value”

prjNum (Num n) = n
prjNum  _      = error “bad numeric value”

prjBool (Bool b) = b
prjBool  _       = error “bad boolean value”

binOp inj f = Fun (\i -> (Fun (\j -> inj (f (prjNum i) (prjNum j)))))


-- environments mapping variables to values

type Env = [(Var, Value)]

getval x env =  case lookup x env of
                  Just v  -> v
                  Nothing -> error (“no value for ” ++ x)


-- an environment-based evaluation function

eval env (Occ x) = getval x env
eval env (Use c) = getval c prims
eval env (Lit k) = Num k
eval env (App m n) = prjFun (eval env m) (eval env n)
eval env (Abs x m) = Fun  (\v -> eval ((x,v) : env) m)
eval env (Rec x m) = f where f = eval ((x,f) : env) m


-- a (fixed) “environment” of language primitives

times = binOp Num  (*)
minus = binOp Num  (-)
equal = binOp Bool (==)
cond  = Fun (\b -> Fun (\x -> Fun (\y -> if (prjBool b) then x else y)))

prims = [ ('*', times), ('-', minus), ('==', equal), ('if', cond) ]


-- a term representing factorial and a 'wrapper' for evaluation

facTerm = Rec 'f' (Abs 'n'
              (App (App (App (Use 'if')
                   (App (App (Use '==') (Occ 'n')) (Lit 0))) (Lit 1))
                   (App (App (Use '*')  (Occ 'n'))
                        (App (Occ 'f')  
                             (App (App (Use '-') (Occ 'n')) (Lit 1))))))

fac n = prjNum (eval [] (App facTerm (Lit n)))
"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_Iterative [
"
Iterative Haskell programmer
(former Pascal programmer)

fac n = result (for init next done)
        where init = (0,1)
              next   (i,m) = (i+1, m * (i+1))
              done   (i,_) = i==n
              result (_,m) = m
for i n d = until d n i
"
	| for |
	for := [ :i :n :d | i evaluate: n until: d ].
	
	fac := [ :n |
		| init next done result |
		init := {0 . 1}.
		next := [ :i_m |
			| i m | i := i_m first. m := i_m second.
			{ i+1 . m*(i+1) } ].
		done := [ :i__ |
			| i | i := i__ first.
			i=n ].
		result := [ :__m |
			| m | m := __m second.
			m ].
		result value: (for value: init value: next value: done)
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_IterativeOneliner [
"
Iterative one-liner Haskell programmer
(former APL and C programmer)

fac n = snd (until ((>n) . fst) (\(i,m) -> (i+1, i*m)) (1,1))
"
	fac := [ :n |
		(#(1 1)
			evaluate: [ :i_m | { i_m first + 1 . i_m first * i_m second } ]
			until: (□>n) ∘ □ first "NB how #first will not work!"
		) second
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Junior [
"
Junior Haskell programmer
(beginning Peano player)

fac  0    =  1
fac (n+1) = (n+1) * fac n

"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_ListEncoding [
"
List-encoding Haskell programmer
(prefers to count in unary)

arb = ()    -- 'undefined' is also a good RHS, as is 'arb' :)

listenc n = replicate n arb
listprj f = length . f . listenc

listprod xs ys = [ i (x,y) | x<-xs, y<-ys ]
                 where i _ = arb

facl []         = listenc  1
facl n@(_:pred) = listprod n (facl pred)

fac = listprj facl
"
	| arb listenc listprj listprod facl |
	arb := nil.
	listenc := [ :n | arb replicate: n ].
	listprj := [ :f | (□ size) ∘ f ∘ listenc ].
	listprod := [ :xs :ys | arb replicate: xs size * ys size].
	facl := [ :n |
			n isEmpty
					ifTrue: [ listenc value: 1 ]
					ifFalse: [ listprod value: n value: (facl value: n allButFirst) ]
	].
	fac := listprj value: facl.

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Memoizing [
"
Memoizing Haskell programmer
(takes Ginkgo Biloba daily)

facs = scanl (*) 1 [1..]

fac n = facs !! n

"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_Origamist0 [
"
Origamist Haskell programmer
(always starts out with the “basic Bird fold”)

-- (curried, list) fold and an application

fold c n []     = n
fold c n (x:xs) = c x (fold c n xs)

prod = fold (*) 1


-- (curried, boolean-based, list) unfold and an application

unfold p f g x = 
  if p x 
     then [] 
     else f x : unfold p f g (g x)

downfrom = unfold (==0) id pred

-- several versions of factorial, all (extensionally) equivalent

fac   = prod . downfrom
fac'  = refold  (*) 1 (==0) id pred
fac'' = refold' (*) 1 (==0) id pred
"
	| fold prod unfold downfrom refold refold′ |
	fold := [ :c :n :xxs |
		xxs isEmpty
			ifTrue: [ n ]
			ifFalse: [ c value: xxs first value: (fold value: c value: n value: xxs allButFirst) ]
		].
	prod := fold value: #* value: 1.
	
	unfold := [ :p :f :g :x |
		(p value: x)
			ifTrue: [ #() ]
			ifFalse: [ {f value: x}, (unfold value: p value: f value: g value: (g value: x)) ]
	].
	
	downfrom := unfold value: (□=0) value: (□ yourself) value: (□-1).
	fac := prod ∘ downfrom.	
	
	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Origamist1 [
"
Origamist Haskell programmer
(always starts out with the “basic Bird fold”)

-- (curried, list) fold and an application

fold c n []     = n
fold c n (x:xs) = c x (fold c n xs)

prod = fold (*) 1


-- (curried, boolean-based, list) unfold and an application

unfold p f g x = 
  if p x 
     then [] 
     else f x : unfold p f g (g x)

downfrom = unfold (==0) id pred

-- hylomorphisms, as-is or 'unfolded' (ouch! sorry ...)

refold  c n p f g   = fold c n . unfold p f g

-- several versions of factorial, all (extensionally) equivalent

fac   = prod . downfrom
fac'  = refold  (*) 1 (==0) id pred
fac'' = refold' (*) 1 (==0) id pred
"
	| fold prod unfold downfrom refold |
	fold := [ :c :n :xxs |
		xxs isEmpty
			ifTrue: [ n ]
			ifFalse: [ c value: xxs first value: (fold value: c value: n value: xxs allButFirst) ]
		].
	prod := fold value: #* value: 1.
	
	unfold := [ :p :f :g :x |
		(p value: x)
			ifTrue: [ #() ]
			ifFalse: [ {f value: x}, (unfold value: p value: f value: g value: (g value: x)) ]
	].
	
	downfrom := unfold value: (□=0) value: (□ yourself) value: (□-1).
	refold := [ :c :n :p :f :g |
		(fold value: c value: n) ∘ (unfold value: p value: f value: g)
	].
	fac := refold value: #* value: 1 value: □=0 value: □ yourself value: □-1.
	
	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Origamist2 [
"
Origamist Haskell programmer
(always starts out with the “basic Bird fold”)

-- (curried, list) fold and an application

fold c n []     = n
fold c n (x:xs) = c x (fold c n xs)

prod = fold (*) 1


-- (curried, boolean-based, list) unfold and an application

unfold p f g x = 
  if p x 
     then [] 
     else f x : unfold p f g (g x)

downfrom = unfold (==0) id pred

-- hylomorphisms, as-is or 'unfolded' (ouch! sorry ...)

refold' c n p f g x = 
  if p x 
     then n 
     else c (f x) (refold' c n p f g (g x))


-- several versions of factorial, all (extensionally) equivalent

fac   = prod . downfrom
fac'  = refold  (*) 1 (==0) id pred
fac'' = refold' (*) 1 (==0) id pred
"
	| fold prod unfold downfrom refold′ |
	fold := [ :c :n :xxs |
		xxs isEmpty
			ifTrue: [ n ]
			ifFalse: [ c value: xxs first value: (fold value: c value: n value: xxs allButFirst) ]
		].
	prod := fold value: #* value: 1.
	
	unfold := [ :p :f :g :x |
		(p value: x)
			ifTrue: [ #() ]
			ifFalse: [ {f value: x}, (unfold value: p value: f value: g value: (g value: x)) ]
	].
	
	downfrom := unfold value: (□=0) value: (□ yourself) value: (□-1).
	refold′ := [ :c :n :p :f :g :x |
		(p value: x)
			ifTrue: [ n ]
			ifFalse: [ c value: (f value: x) value: (refold′ value: c value: n value: p value: f value: g value: (g value: x)) ]
	].
	fac := refold′ value: #* value: 1 value: □=0 value: □ yourself value: □-1.
	
	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_PhD [
"
Ph.D. Haskell programmer
(ate so many bananas that his eyes bugged out, now he needs new lenses!)

-- explicit type recursion based on functors

newtype Mu f = Mu (f (Mu f))  deriving Show

in      x  = Mu x
out (Mu x) = x


-- cata- and ana-morphisms, now for *arbitrary* (regular) base functors

cata phi = phi . fmap (cata phi) . out
ana  psi = in  . fmap (ana  psi) . psi


-- base functor and data type for natural numbers,
-- using a curried elimination operator

data N b = Zero | Succ b  deriving Show

instance Functor N where
  fmap f = nelim Zero (Succ . f)

nelim z s  Zero    = z
nelim z s (Succ n) = s n

type Nat = Mu N


-- conversion to internal numbers, conveniences and applications

int = cata (nelim 0 (1+))

instance Show Nat where
  show = show . int

zero = in   Zero
suck = in . Succ       -- pardon my 'French' (Prelude conflict)

plus n = cata (nelim n     suck   )
mult n = cata (nelim zero (plus n))


-- base functor and data type for lists

data L a b = Nil | Cons a b  deriving Show

instance Functor (L a) where
  fmap f = lelim Nil (\a b -> Cons a (f b))

lelim n c  Nil       = n
lelim n c (Cons a b) = c a b

type List a = Mu (L a)


-- conversion to internal lists, conveniences and applications

list = cata (lelim [] (:))

instance Show a => Show (List a) where
  show = show . list

prod = cata (lelim (suck zero) mult)

upto = ana (nelim Nil (diag (Cons . suck)) . out)

diag f x = f x x

fac = prod . upto

"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_Pointless [
"
Pointless (ahem) “Points-free” Haskell programmer
(studied at Oxford)
fac = foldr (*) 1 . enumFromTo 1
"
	fac := (□ foldr: #* fromSeed: 1) ∘ (1 to: □).

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_PostDoc [
"
Post-doc Haskell programmer
(from Uustalu, Vene and Pardo’s “Recursion Schemes from Comonads” [4])

-- explicit type recursion with functors and catamorphisms

newtype Mu f = In (f (Mu f))

unIn (In x) = x

cata phi = phi . fmap (cata phi) . unIn


-- base functor and data type for natural numbers,
-- using locally-defined 'eliminators'

data N c = Z | S c

instance Functor N where
  fmap g  Z    = Z
  fmap g (S x) = S (g x)

type Nat = Mu N

zero   = In  Z
suck n = In (S n)

add m = cata phi where
  phi  Z    = m
  phi (S f) = suck f

mult m = cata phi where
  phi  Z    = zero
  phi (S f) = add m f


-- explicit products and their functorial action

data Prod e c = Pair c e

outl (Pair x y) = x
outr (Pair x y) = y

fork f g x = Pair (f x) (g x)

instance Functor (Prod e) where
  fmap g = fork (g . outl) outr


-- comonads, the categorical 'opposite' of monads

class Functor n => Comonad n where
  extr :: n a -> a
  dupl :: n a -> n (n a)

instance Comonad (Prod e) where
  extr = outl
  dupl = fork id outr


-- generalized catamorphisms, zygomorphisms and paramorphisms

gcata :: (Functor f, Comonad n) =>
           (forall a. f (n a) -> n (f a))
             -> (f (n c) -> c) -> Mu f -> c

gcata dist phi = extr . cata (fmap phi . dist . fmap dupl)

zygo chi = gcata (fork (fmap outl) (chi . fmap outr))

para :: Functor f => (f (Prod (Mu f) c) -> c) -> Mu f -> c
para = zygo In


-- factorial, the *hard* way!

fac = para phi where
  phi  Z             = suck zero
  phi (S (Pair f n)) = mult f (suck n)
  

-- for convenience and testing

int = cata phi where
  phi  Z    = 0
  phi (S f) = 1 + f

instance Show (Mu N) where
  show = show . int

"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_Reference [
	fac := #factorial.

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Senior [
"
Senior Haskell programmer
fac n = foldr (*) 1 [1..n]
"
	fac := [ :n |
		(1 to: n) foldr: #* fromSeed: 1
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Sophomore [
"
Sophomore Haskell programmer, at MIT
(studied Scheme as a freshman)

fac = (\(n) ->
        (if ((==) n 0)
            then 1
            else ((*) n (fac ((-) n 1)))))
"
	fac := [ :n |
		(#= value: n value: 0)
			ifTrue: [1]
			ifFalse: [ #* value: n value: (fac value: (#- value: n value: 1)) ]
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_Static [
"
Static Haskell programmer
(he does it with class, he’s got that fundep Jones!
After Thomas Hallgren’s “Fun with Functional Dependencies” [7])

-- static Peano constructors and numerals

data Zero
data Succ n

type One   = Succ Zero
type Two   = Succ One
type Three = Succ Two
type Four  = Succ Three


-- dynamic representatives for static Peanos

zero  = undefined :: Zero
one   = undefined :: One
two   = undefined :: Two
three = undefined :: Three
four  = undefined :: Four


-- addition, a la Prolog

class Add a b c | a b -> c where
  add :: a -> b -> c
  
instance              Add  Zero    b  b
instance Add a b c => Add (Succ a) b (Succ c)


-- multiplication, a la Prolog

class Mul a b c | a b -> c where
  mul :: a -> b -> c

instance                           Mul  Zero    b Zero
instance (Mul a b c, Add b c d) => Mul (Succ a) b d


-- factorial, a la Prolog

class Fac a b | a -> b where
  fac :: a -> b

instance                                Fac  Zero    One
instance (Fac n k, Mul (Succ n) k m) => Fac (Succ n) m

-- try, for 'instance' (sorry):
-- 
--     :t fac four

"
	self skip
]

{ #category : #tests }
FritzRuehrTest >> test_TenuredProf [
"
Tenured professor
(teaching Haskell to freshmen)

fac n = product [1..n]
"
	fac := [ :n |
		(1 to: n) product
	].

	self assertGood
]

{ #category : #tests }
FritzRuehrTest >> test_YetAnotherSenior [
"
Yet another senior Haskell programmer
(leaned so far right he came back left again!)
-- using foldr to simulate foldl
fac n = foldr (\x g n -> g (x*n)) id [1..n] 1
"
	fac := [ :n |
		((1 to: n) foldr: [ :x :g :n′ | g value: x*n′ ] fromSeed: #yourself) value: 1
	].

	self assertGood
]

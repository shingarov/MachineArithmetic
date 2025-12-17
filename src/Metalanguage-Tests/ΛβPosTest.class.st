Class {
	#name : #'ΛβPosTest',
	#superclass : #SpriteLangPosTest,
	#category : #'Metalanguage-Tests'
}

{ #category : #running }
ΛβPosTest >> parserClass [
	^ΛβParser
]

{ #category : #tests }
ΛβPosTest >> test_1 [
"Example ex2 from Section 2.3 of Vazou–Bakst–Jhala's ICFP'15 paper,
 NOT manually translated into λP.
 Cf. L6PosTest>>test_compose00
"
	self processString: '
⟦val cmp : ∀ < p : ''b => ''c => bool
             , q : ''a => ''b => bool
             , r : ''a => ''c => bool
             >.
           {x::a, w::b<q x> |- c<p w> <: c<r x>}
           (x:''a => w:''b[v|q value: x value: v] => z:''c[v|p value: w value: v] => bool[v|r value: x value: z])
              => (y:''b => ''c[v|p value: y value: v])
              => (z:''a => ''b[v|q value: z value: v])
              =>  x:''a
              => ''c[v | r value: x value: v ]⟧
let compose = (cha, f, g, x) => {
  let t1 = g(x);
  let t2 = f(t1);
  let t3 = cha(x, t1, t2);
  t2
};



'
]

{ #category : #tests }
ΛβPosTest >> test_compose00 [
"Example ex2 from Section 2.3 of Vazou–Bakst–Jhala's ICFP'15 paper,
 NOT manually translated into λP.
 Cf. L6PosTest>>test_compose00
"
	self processString: '
⟦val cmp : ∀ < p : ''b => ''c => bool
             , q : ''a => ''b => bool
             , r : ''a => ''c => bool
             >.
           
                 (x:''a => w:''b[v|q value: x value: v] => z:''c[v|p value: w value: v] => bool[v|r value: x value: z])
              => (y:''b => ''c[v|p value: y value: v])
              => (z:''a => ''b[v|q value: z value: v])
              =>  x:''a
              => ''c[v | r value: x value: v ]⟧
let compose = (cha, f, g, x) => {
  let t1 = g(x);
  let t2 = f(t1);
  let t3 = cha(x, t1, t2);
  t2
};



'
]

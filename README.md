# A mathematical foundation for Smalltalk-25
Originally when this repo was first created,
we had in mind a much more modest / narrow scope:
back then we simply wanted a model of finite-precision machine integers
which would be more suitable for the superoptimizing Smalltalk JIT
we were building, than the elaborate model of ℤ (the hierarchy of _Integer_)
which we as Smalltalkers are rightly proud of.


However, as work on the superoptimizer advanced,
it became progressively more obvious that the conceptual gap
between the functionality consumed by the modern program analysis algorithms,
and the pointwise-calculational term reducers provided by
any existing Smalltalk-80 host,
is hopelessly too wide to bridge in an ad-hoc fashion.


MachineArithmetic addresses this problem **systematically**.
We begin by bringing in some rudimentary combinatorics, starting from
an FFI to the [Z3 SMT solver](https://github.com/Z3Prover/z3),
and a crude first approximation to a graph search.
Over that foundation we implement a minimalistic equational prover,
mostly following 
[Cosman&ndash;Jhala ICFP'17](https://dl.acm.org/doi/10.1145/3110270)
and
[Vazou et al. POPL'18](https://dl.acm.org/doi/10.1145/3158141)
and consulting
[Liquid Fixpoint](https://github.com/ucsd-progsys/liquid-fixpoint)
as a reference implementation of the algorithm.

## How to load

### ...into Pharo or GT

````
Metacello new
  baseline: 'MachineArithmetic';
  repository: 'github://shingarov/MachineArithmetic:pure-z3';
  load.
````

#### To create fresh image for development

Either use shortcut:

```
git clone https://github.com/shingarov/MachineArithmetic
cd MachineArithmetic/pharo
make
./pharo MachineArithmetic.image
```

...or do it by hand:

  1. Clone the repository

     ```
     git clone https://github.com/shingarov/MachineArithmetic
     ```

  2. Download Pharo

     ```
     # Be carefull, running a script downloaded from internet is not advisable!
     curl https://get.pharo.org/64/80+vm | bash
     ```

  4. Load code into Pharo image:

     ```
     ./pharo Pharo.image save MachineArithmetic
     ./pharo MachineArithmetic.image metacello install tonel://./MachineArithmetic/src BaselineOfMachineArithmetic
     ./pharo MachineArithmetic.image eval --save "(IceRepositoryCreator new location: 'MachineArithmetic' asFileReference; createRepository) register"
     ```

### ...into Smalltalk/X

**NOTE**: The following instructions assume you have
a recent [Smalltalk/X jv-branch][1], i.e., a version newer than 2021-12-09
(older versions might not have required Pharo compatibility support &mdash; Tonel, PackageManifests, ... &mdash; built in).

**NOTE**: Following instructions *load only core* MachineArithmetic package (basically Z3 bindings) as the
rest is not supported on Smalltalk/X at the moment. 

Either use shortcut:

```
git clone https://github.com/shingarov/MachineArithmetic
cd MachineArithmetic/stx
make
make run
```

...or do it by hand:

 1. Clone the repository:

    ````
    git clone https://github.com/shingarov/MachineArithmetic.git
    ````

 2. In Smalltalk/X, execute:

    ```
    "/ Tell Smalltalk/X where to look for MachineArithmetic packages
    Smalltalk packagePath add: '/where/you/cloned/it/MachineArithmetic'.

    "/ Load MachineArithmetic
    Smalltalk loadPackage: 'BaselineOfMachineArithmetic'.
    ```

## How to load Z3 interface only

See [README_Z3_bindings.md](README_Z3_bindings.md)



[1]: https://swing.fit.cvut.cz/projects/stx-jv

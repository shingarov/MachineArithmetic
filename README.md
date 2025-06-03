# A mathematical foundation for Smalltalk-25
This repo contains the code for the theorem prover we describe in our papers
[Towards a Dynabook for verified VM construction](https://doi.org/10.1016/j.cola.2024.101275)
and [Live Proof-by-Induction](https://openreview.net/pdf?id=AaMvINlc7d).


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

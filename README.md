# Finite-precision Integers in Smalltalk
The motivation for this,
is to make possible to reason over the Smalltalk VM's execution in Smalltalk.
Usually when we write the VM in Smalltalk and debug it in the Smalltalk Debugger,
we tend to approximate machine words by infinite-precision integers from ℤ.
While as Smalltalkers we are rightly proud of the elaborate model of ℤ
implemented in the hierarchy of _Integer_, the entities that the CPU computes
are *not* integers, therefore this approximation results in confusion
and ultimately in subtle bugs.

## How to load

### ...into Pharo

````
Metacello new
  baseline: 'MachineArithmetic';
  repository: 'github://shingarov/MachineArithmetic/src';
  load.
````

#### To create fresh image for development

Either use shortcut:

     ```
     git clone https://github.com/shingarov/MachineArithmetic
     cd MachineArithmetic/pharo
     make
     pharo-ui MachineArithmetic.image
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
     ./pharo archc.image metacello install tonel://./MachineArithmetic/src BaselineOfMachineArithmetic
     ./pharo archc.image eval --save "(IceRepositoryCreator new location: 'MachineArithmetic' asFileReference; createRepository) register"
     ```

### ...into Smalltalk/X

*NOTE*: Following instructions assume you recent Smalltalk/X jv-branch, i.e., version newer than 2021-12-09
(older versions might not have required Pharo compatibility support - Tonel, PackageManifests, ... - built in).

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
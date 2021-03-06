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

To create fresh image (say `machinearithmetic.image`) from currently checked-out revision, do:

````
pharo Pharo.image save machinearithmetic
pharo machinearithmetic.image metacello install tonel://. BaselineOfMachineArithmetic
pharo machinearithmetic.image eval --save "(IceRepositoryCreator new location: '.' asFileReference; createRepository) register"
````

### ...into Smalltalk/X

*NOTE*: Following instruction assume you recent Smalltalk/X jv-branch, i.e., version newer than 2020-09-15
(older versions might not have Tonel support built). 

 1. Clone the repository:

    ````
    git clone https://github.com/shingarov/MachineArithmetic.git
    ````

 3. Compile Z3: 

    ```
    git clone --depth 1 --branch z3-4.8.8 https://github.com/Z3Prover/z3.git
    cd z3 && ./configure -d -b build
    make -j4 -C z3/build
    ```

    Due to (yet!) unknown reason, VM crashes when using stock, optimized `libz3.so`. This has to 
    - and will be - investigated and fixed. Meanwhile, please use custom built `libz3.so`.

 2. In Smalltalk/X, execute: 

    ```
    "/ Tell Smalltalk/X where to look for MachineArithmetic packages
    Smalltalk packagePath add: '/where/you/cloned/it/MachineArithmetic'.

    "/ Load MachineArithmetic
    Smalltalk loadPackage: 'MachineArithmetic-FFI-SmalltalkX'.
    Smalltalk loadPackage: 'MachineArithmetic'.
    Smalltalk loadPackage: 'MachineArithmetic-Tests'.

    "/ Set `libz3.so` to use
    (Smalltalk at: #LibZ3) libraryName: '/where/you/cloned/it/z3/build/libz3.so'
    ```
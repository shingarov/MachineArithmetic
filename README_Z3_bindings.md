# Z3 interface for Smalltalk

This package provides an interface to the [Z3 Theorem Prover](https://github.com/Z3Prover/z3)
by wrapping Z3's [C API](http://z3prover.github.io/api/html/z3__api_8h.html).

It uses Z3 shared library which should be installed by other means (e.g., `apt install libz3-4`).
To use specific Z3 library, execute:

````
LibZ3 libraryName: '/home/user/path/to/z3/build/libz3.so'.
````

## How to load

### ...into Pharo or GT

````
Metacello new
  baseline: 'MachineArithmetic';
  repository: 'github://shingarov/MachineArithmetic:pure-z3';
  load: 'Z3only'
````

### ...into Smalltalk/X

 1. Clone the repository:

    ````
    git clone https://github.com/shingarov/MachineArithmetic.git
    ````

 2. In Smalltalk/X, execute:

    ```
    "/ Tell Smalltalk/X where to look for MachineArithmetic packages
    Smalltalk packagePath add: '/where/you/cloned/it/MachineArithmetic'.

    "/ Load MachineArithmetic
    Smalltalk loadPackage: 'MachineArithmetic'.
    ```


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


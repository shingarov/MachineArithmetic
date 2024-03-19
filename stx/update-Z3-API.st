| repo |

'LibZ3-generated.st' asFilename fileIn.

Z3 class methodsDo: [ :mthd | mthd package: Z3 package ].
LibZ3 methodsDo: [ :mthd | mthd package: LibZ3 package ].

repo := TonelRepository new directory:'..' asFileReference / 'src'.
{ Z3 . LibZ3 } do: [:class |
    | mcpkg mcwc mcvi mcversion |

    mcpkg := MCPackage named: class package.
    mcwc := mcpkg workingCopy.
    mcvi := MCVersionInfo forPackage: class package.
    [
	mcversion := mcwc newVersion.
	mcversion snapshot options includeExtrasForSTX:false.
    ] on:MCVersionNameAndMessageRequest do:[:ex |
	ex resume:(Array with:mcvi name with:mcvi message)
    ].
    mcversion info:mcvi.
    repo storeVersion:mcversion.
].


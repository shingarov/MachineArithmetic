#/usr/bin/python3
"""
Script to generate Smalltalk Z3 API (FFI callouts) from Z3 C headers.

Generated code is printed to standard output in form of old chunk-format
changeset. By default, `apigen.py` output is suitable for Smalltalk/X. Use
option `--pharo` to output changeset suitable for Pharo.

Z3 APIs are defined in multiple header files (see `Z3_API_HEADER_FILES_TO_SCAN` in
Z3's top-level `CMakeLists.txt`)


  z3_api.h
  z3_ast_containers.h
  z3_algebraic.h
  z3_polynomial.h
  z3_rcf.h
  z3_fixedpoint.h
  z3_optimization.h
  z3_fpa.h
  z3_spacer.h


All of them should be passed to `apigen.py`. Alternatively, you may use
`--z3-source=/path/to/z3` to point `apigen.py` to Z3 sources - it will then
scan all required headers from there.

### Workflow in a nutshell ###

  1. Update / fix `apigen.py` (mostly you would need to update mapping
     from Z3 types to their Smalltalk counterparts, search for

        VOID            = ScalarType('VOID'            , 'void')

     in `apigen.py` source.

  2. If you're adding new type, create the class in Smalltalk and
     commit.

  3. Regenerate API classes (`Z3` and `LibZ3`) for both, Pharo
     and Smalltalk/X:

        make -C pharo Z3_SOURCE_DIR=/path/to/z3/sources update-Z3-API
        make -C stx Z3_SOURCE_DIR=/path/to/z3/sources update-Z3-API

     This will run `apigen.py`, load generated changeset into smalltalk
     and save modification back to the disk.

  4. Test changes:

        make -C pharo clean test
        make -C stx clean test

  5. Review changes and - if happy - commit:

        git diff
        git add apigen.py \
          MachineArithmetic-FFI-Pharo/LibZ3.class.st \
          MachineArithmetic-FFI-SmalltalkX/LibZ3.class.st \
          MachineArithmetic/Z3.class.st
        git commit

### Using `apigen.py` manually ###

  1. Update / fix `apigen.py` (mostly you would need to update mapping
     from Z3 types to their Smalltalk counterparts, search for

        VOID            = ScalarType('VOID'            , 'void')

     in `apigen.py` source.

  2. If you're adding new type, create the class in Smalltalk and
     commit.

  3. Run `apigen.py`:

        python3 apigen.py --pharo --z3-source=../z3 > pharo/LibZ3-generated.st

     Do not forget to use `--pharo` when working in Pharo!

  3. Load generated changeset (`pharo/LibZ3-generated.st`) into smalltalk.

  4. Test

  5. Commit new / updated code from smalltalk IDE.

  6. Repeat until happy.

"""

import sys
import io
import os.path
import argparse
import re
import enum


from itertools import chain

class BaseType:
    def __init__(self, name):
        self._name = name

    def __str__(self):
        return self._name

    def is_array_type(self):
        return False

    def is_z3_type(self):
        return False

    def is_z3context_type(self):
        return False

    def is_z3contexted_type(self):
        return False

    def is_z3ast_type(self):
        return False

    def is_z3ast_sub_type(self):
        return False

    @property
    def name(self):
        return self._name

    @property
    def uffi_typename(self):
        raise Exception("Subclass reponsibility")

class ScalarType(BaseType):
    def __init__(self, name, uffi_typename = None, stx_typename = None):
        super().__init__(name)
        self._uffi_typename = uffi_typename
        self._stx_typename = stx_typename if stx_typename else uffi_typename

    @property
    def uffi_typename(self):
        if self._uffi_typename:
            return self._uffi_typename
        else:
            raise Exception(f"Type {self._name} not (yet) supported.")

class Z3Type(BaseType):
    def __init__(self, name, typename = None):
        super().__init__(name)
        self._typename = typename

    def is_z3_type(self):
        return True

    def is_z3context_type(self):
        return self._name == 'CONTEXT'

    @property
    def uffi_typename(self):
        if self._typename:
            return self._typename
        else:
            raise Exception(f"Type {self._name} not (yet) supported.")

class ArrayType(BaseType):
    def __init__(self, ty, size = None):
        super().__init__(ty.name)
        self._type = ty
        self._size = size

    @property
    def uffi_typename(self):
        return 'FFIExternalArray'

    @property
    def element_type(self):
        return self._type

    def is_array_type(self):
        return True

    def __str__(self):
        return f"{str(self._type)}[{str(self._size) if self._size else ''}]"

class Z3CtxdType(Z3Type):
    def is_z3contexted_type(self):
        return True

class Z3ASTType(Z3CtxdType):
    def is_z3ast_type(self):
        return True

class Z3ASTSubType(Z3CtxdType):
    def is_z3ast_sub_type(self):
        return True

class ArgumentType(enum.Flag):
    IN  = 1
    OUT = 2

class Argument:
    def __init__(self, ty, flags):
        self._flags = flags
        self._type = ty

    @property
    def type(self):
        return self._type

    @property
    def flags(self):
        return self._flags

    def arg_name(self):
        return self.name

    def tmp_name(self):
        return self.arg_name() + 'Ext'

    def is_out_arg(self):
        return ArgumentType.OUT in self._flags

    def is_array_arg(self):
        return self._type.is_array_type()

VOID            = ScalarType('VOID'            , 'void')
VOID_PTR        = ScalarType('VOID_PTR'        , 'void *')
INT             = ScalarType('INT'             , 'int')
UINT            = ScalarType('UINT'            , 'uint')
INT64           = ScalarType('INT64'           , 'int64')
UINT64          = ScalarType('UINT64'          , 'uint64')
STRING          = ScalarType('STRING'          , 'char *')
STRING_PTR      = ScalarType('STRING_PTR'      , 'char **')
BOOL            = ScalarType('BOOL'            , 'bool')
PRINT_MODE      = ScalarType('PRINT_MODE'      )
ERROR_CODE      = ScalarType('ERROR_CODE'      , 'uint')
DOUBLE          = ScalarType('DOUBLE'          , 'double')
FLOAT           = ScalarType('FLOAT'           , 'float')
CHAR            = ScalarType('CHAR'            , 'char')
CHAR_PTR        = ScalarType('CHAR_PTR'        , 'char *')

SYMBOL          = Z3CtxdType('SYMBOL'          , 'Z3Symbol' )
CONFIG          =     Z3Type('CONFIG'          , 'Z3Config')
CONTEXT         =     Z3Type('CONTEXT'         , 'Z3Context')
AST             =  Z3ASTType('AST'             , 'Z3AST')
APP             =  Z3ASTType('APP'             , 'Z3AST')
SORT            =Z3ASTSubType('SORT'           , 'Z3Sort')
FUNC_DECL       =Z3ASTSubType('FUNC_DECL'      , 'Z3FuncDecl')
PATTERN         = Z3CtxdType('PATTERN'         , 'Z3Pattern')
MODEL           = Z3CtxdType('MODEL'           , 'Z3Model')
LITERALS        =     Z3Type('LITERALS'        )
CONSTRUCTOR     = Z3CtxdType('CONSTRUCTOR'     , 'Z3Constructor')
CONSTRUCTOR_LIST =    Z3CtxdType('CONSTRUCTOR_LIST' , 'Z3ConstructorList')
SOLVER          = Z3CtxdType('SOLVER'          , 'Z3Solver')
SOLVER_CALLBACK =     Z3Type('SOLVER_CALLBACK' )
GOAL            =     Z3Type('GOAL'            )
TACTIC          =     Z3Type('TACTIC'          )
PARAMS          = Z3CtxdType('PARAMS'          , 'Z3ParameterSet')
PROBE           =     Z3Type('PROBE'           )
STATS           =     Z3Type('STATS'           )
AST_VECTOR      = Z3CtxdType('AST_VECTOR'      , 'Z3ASTVector')
AST_MAP         =     Z3Type('AST_MAP'         )
APPLY_RESULT    =     Z3Type('APPLY_RESULT'    )
FUNC_INTERP     =     Z3Type('FUNC_INTERP'     )
FUNC_ENTRY      =     Z3Type('FUNC_ENTRY'      )
FIXEDPOINT      = Z3CtxdType('FIXEDPOINT'      , 'Z3Fixedpoint')
OPTIMIZE        =     Z3Type('OPTIMIZE'        )
PARAM_DESCRS    =     Z3Type('PARAM_DESCRS'    )
RCF_NUM         =     Z3Type('RCF_NUM'         )



API_MATCHER = re.compile("/\*\*\n    (.*?(?=\*/))\*/\n\s+([^;/]+)", re.M | re.S)
DEF_MATCHER = re.compile("def_API\(.*\)\n", re.M | re.S)
FUN_MATCHER = re.compile("\w+\s+Z3_API\s+\w+\s*\((.*)\)", re.M | re.S)
ARG_MATCHER = re.compile("\w+(?:(?:\s+const)?(?:\s*\*)?\s+(\w+)(?:\[\])?)?,?")

def parse(header_path):
    """
    Parse a Z3 header file and return an iterable on APIs found.
    """
    with open(header_path) as header:
        candidates = API_MATCHER.findall(header.read())
        definitions = [ candidate for candidate in candidates if DEF_MATCHER.search(candidate[0]) ]
        apis = [ API(definition[0], definition[1]) for definition in definitions ]
        return apis


class API:
    def __init__(self, comment, prototype):
        self.comment = comment.replace("\"", "\'").replace("!", "!!")
        self.prototype = prototype

        def def_API(cname, rettype, args):
            self.cname = cname
            self.rettype = rettype
            self.args = args

        def _in(t):
            return Argument(t, ArgumentType.IN)

        def _in_array(s, t):
            return Argument(ArrayType(t, s), ArgumentType.IN)

        def _out(t):
            return Argument(ArrayType(t, 1), ArgumentType.OUT)

        def _out_array(s, t):
            return Argument(ArrayType(t, s), ArgumentType.OUT)

        def _inout_array(s, t):
            return Argument(ArrayType(t, s), ArgumentType.IN|ArgumentType.OUT)

        eval(DEF_MATCHER.search(comment).group(0))

        prototype_arguments = FUN_MATCHER.search(prototype)
        if not prototype_arguments:
            breakpoint()

        prototype_arguments = prototype_arguments.group(1)
        if prototype_arguments != 'void':
            argnames = ARG_MATCHER.findall(prototype_arguments)
            if len(self.args) != len(argnames):
                import pdb; pdb.set_trace()

            assert len(self.args) == len(argnames)
            for i in range(0, len(argnames)):
                argname = argnames[i]
                if argname == None or argname == "":
                    argname = 'arg' + str(i)
                self.args[i].name = argname

    def header(self, argnames = None):
        assert argnames == None or len(argnames) == len(self.args)

        if argnames == None:
            argnames = [arg.name for arg in self.args]

        n = self.cname
        if n.startswith('Z3_'):
            n = n[3:]
        if len(argnames) > 0:
            n += ': ' + argnames[0]
        if len(argnames) > 1:
            for argname in argnames[1:]:
                n += ' _: ' + argname
        return n

    def has_context_arg(self):
        for arg in self.args:
            if arg.type.is_z3context_type():
                return True
        return False

    def context_arg_name(self):
        for arg in self.args:
            if arg.type.is_z3context_type():
                return arg.name
        raise Exception("Oops, this API does not take any Context argument")

PUBLIC_METHOD_TEMPLATE = """
!Z3 class methodsFor: 'API'!
{public_header}
    "
    {comment}

        AUTOMATICALLY GENERATED BY apigen.py. DO NOT EDIT!!
    "
    {public_body}

! !

"""

PRIVATE_METHOD_TEMPLATE = """
!LibZ3 methodsFor: 'API - private'!
{private_header}
    "
        PRIVATE - DO NOT USE!!

        {prototype};

        AUTOMATICALLY GENERATED BY apigen.py. DO NOT EDIT!!
    "
    {private_body}
! !

"""

class Generator:
    def generate(self, apis):
        for api in apis:
            self.generate1(api)

    def generate1(self, api, public = True, private = True):
        if public:
            source = PUBLIC_METHOD_TEMPLATE.format(
                comment       = api.comment,
                prototype     = api.prototype,
                public_header = self.public_header(api),
                public_body   = self.public_body(api)
            )
            source = self.reformat(source)
            print(source)

        if private:
            source = PRIVATE_METHOD_TEMPLATE.format(
                comment       = api.comment,
                prototype     = api.prototype,
                private_header= self.private_header(api),
                private_body  = self.private_body(api),
            )
            source = self.reformat(source)
            print(source)

    def reformat(self, source):
        """
        Reformat the source to conform to dialect's convetion regarding
        tabs/spaces and/or line ends.
        """
        return source

    def public_header(self, api):
        return api.header()

    def private_header(self, api, argnames = None):
        return '_' + api.header(argnames)

    def public_body(self, api):
        try:
            # Following is just to get an exception for
            # unsupported types
            self.type2ffi(api.rettype)
            for arg in api.args:
                self.type2ffi(arg.type)

            body = ''
            temps = ['retval']

            # Ensure all Z3 objects are valid upon entry.
            for arg in api.args:
                if arg.type.is_z3_type() and not self.arg_passed_as_raw_pointer(api, arg):
                    if arg.type.is_z3ast_sub_type():
                        body += f"{arg.name} ensureValidZ3ASTOfKind: {arg.type.name}_AST.\n    "
                    elif arg.type.is_z3ast_type():
                        body += f"{arg.name} ensureValidZ3AST.\n    "
                    else:
                        body += f"{arg.name} ensureValidZ3Object.\n    "
                elif arg.type.is_array_type() and arg.flags != ArgumentType.OUT and api.cname not in ['Z3_mk_constructor']:
                    eltype = arg.type.element_type
                    if eltype.is_z3ast_sub_type():
                        body += f"{arg.name} ensureValidZ3ASTArrayOfKind: {arg.type.name}_AST.\n    "
                    elif eltype.is_z3ast_type():
                        body += f"{arg.name} ensureValidZ3ASTArray.\n    "
                    elif eltype.is_z3_type():
                        body += f"{arg.name} ensureValidZ3ObjectArray.\n    "

            # Declare temps used for arrays and return value (if needed)
            array_args = [ arg for arg in api.args if arg.is_array_arg() ]
            for arg in array_args:
                temps.append(arg.tmp_name())
                if arg.type.element_type.is_z3_type():
                    body += f"{arg.tmp_name()} := self externalArrayFrom: {arg.name}.\n    "
                elif arg.type.element_type.name == 'UINT':
                    body += f"{arg.tmp_name()} := Z3Object externalU32ArrayFrom: {arg.name}.\n    "
                else:
                    raise Exception(f"arrays of type {arg.type.element_type} not (yet) supported")

            # Call the API
            body += f"retval := lib {self.private_header(api, [arg.tmp_name() if arg in array_args else arg.arg_name() for arg in api.args])}.\n    "

            # Free all external arrays...
            for arg in array_args:
                if arg.is_out_arg():
                    eltype = arg.type.element_type
                    elval = 'v' if arg.arg_name() != 'v' else 'value'
                    elidx = 'i' if arg.arg_name() != 'i' else 'index'
                    body += f"1 to: {arg.arg_name()} size do: [ :i |\n    "
                    body += f"    | {elval} |\n\n    "
                    if eltype.is_z3contexted_type():
                        body += f"    {elval} := {self.type2ffi(eltype)} fromExternalAddress: (Z3Object externalArray: {arg.tmp_name()} pointerAt: {elidx}) inContext: {api.context_arg_name()}.\n    "
                    elif eltype.is_z3_type():
                        body += f"    {elval} := {self.type2ffi(eltype)} fromExternalAddress: (Z3Object externalArray: {arg.tmp_name()} pointerAt: {elidx}).\n    "
                    elif eltype.name == 'UINT':
                        body += f"    {elval} := Z3Object externalArray: {arg.tmp_name()} u32At: {elidx}.\n    "
                    else:
                        raise Exception(f"arrays of type {arg.type.element_type} not (yet) supported")

                    body += f"    {arg.arg_name()} at: {elidx} put: {elval}.\n    "
                    body +=  "].\n    "
                body += f"{arg.tmp_name()} notNil ifTrue:[{arg.tmp_name()} free].\n    "

            # Check whether API call resulted in an error
            if api.has_context_arg():
                # For some APIs, error check is undesirable...
                if api.cname not in ('Z3_del_context', 'Z3_get_error_code' , 'Z3_get_error_msg'):
                    body += f"{api.context_arg_name()} errorCheck.\n    "

            if (api.rettype.is_z3contexted_type()):
                # If retval is an AST, convert it to appropriate class and return...
                body += f"^ {self.type2ffi(api.rettype)} fromExternalAddress: retval inContext: {api.context_arg_name()}.\n    "
            else:
                # ...just return
                body += '^ retval'

            # Declare all temps:
            body = f"| {' '.join(temps)} |\n\n    " + body

            return body

        except Exception as e:
            return f"^ self error: 'API not (yet) supported: {str(e)}'"

    def private_body(self, api):
        try:
            body  = f"^ self ffiCall: #( {self.type2ffi(api.rettype)} {api.cname} ("
            for arg in api.args:
                nm = arg.name
                ty = self.type2ffi(arg.type)
                if self.arg_passed_as_raw_pointer(api, arg):
                    # For explanation, see the comment below (we add it to the generated
                    # code as well as convenience to whoever's reading the generated code
                    # in Smalltalk)
                    body ="\"\n"                                                                        + \
                      "    In Pharo, one has to type parameter as raw pointer (void*) if one\n"         + \
                      "    wants to pass in (raw) handle.\n"                                            + \
                      "\n"                                                                              + \
                      "    We do this in three cases (Z3_get_ast_kind(), Z3_get_sort() and Z3_get_sort_kind()) in order to\n" + \
                      "    get kind/sort information before instantiating the the class. So, we have\n" + \
                      "    to manually force void* for parameter type.\n"                                  + \
                      "\n"                                                                              + \
                      "    See implementations of #fromExternalAddress:inContext: .\n"                  + \
                      "    \"\n"                                                                        + \
                      "    "                                                                            + \
                      body
                    ty = self.type2ffi(VOID_PTR)

                body += f"{',' if arg != api.args[0] else ''} {ty} {nm}"
            body += ' ) )'
            return body
        except Exception as e:
            return f"^ self error: 'API not (yet) supported: {str(e)}'"

    def arg_passed_as_raw_pointer(self, api, arg):
        if (arg.type == AST and api.cname in ('Z3_get_ast_kind', 'Z3_get_sort')) \
            or (arg.type == SORT and api.cname in ('Z3_get_sort_kind')):
            return True
        else:
            return False

    def type2ffi(self,type):
        return type.uffi_typename

def spaces2tabs(line, tabwidth=4):
    """
    Replaces sequence of tabwidth-spaces with tabs.
    """
    nspaces = 0
    while line[nspaces] == ' ':
        nspaces = nspaces + 1
    ntabs = nspaces // tabwidth
    return ('\t' * ntabs) + line[ntabs * tabwidth:]

def squeakify(source):
    source_in = io.StringIO(source)
    source_out = io.StringIO()
    for line in source_in.readlines():
        source_out.write(spaces2tabs(line))
    return source_out.getvalue()


class GeneratorForPharo(Generator):
    def reformat(self, source):
        return squeakify(source)

Z3_API_HEADER_FILES_TO_SCAN = (
  'z3_api.h',
  'z3_ast_containers.h',
  'z3_algebraic.h',
  'z3_polynomial.h',
  'z3_rcf.h',
  'z3_fixedpoint.h',
  'z3_optimization.h',
  'z3_fpa.h',
  'z3_spacer.h'
)

def main(args):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("header",
                      nargs="*",
                      help="C header files to generate API from")
    parser.add_argument("--pharo",
                      action='store_const',
                      const=True,
                      default=False,
                      help="Generate API for Pharo")
    parser.add_argument("--z3-source",
                      default=None,
                      help="Path to Z3 source where to look for headers")
    options = parser.parse_args(args)

    headers = options.header
    if len(headers) == 0:
        if options.z3_source:
            if not os.path.isdir(options.z3_source):
                sys.stderr.write(f"Error: no such directory: {options.z3_source}\n")
                return 2
            headers = [os.path.join(options.z3_source, 'src', 'api', header) for header in Z3_API_HEADER_FILES_TO_SCAN]
        else:
            sys.stderr.write("Error: no headers specified - consider using --z3-source=... option!\n")
            return 1

    for header in headers:
        if not os.path.isfile(header):
            sys.stderr.write(f"Error: no such file: {header}\n")
            return 3

    apis = chain(*[parse(header) for header in headers])

    if options.pharo:
        generator = GeneratorForPharo()
    else:
        generator = Generator()

    generator.generate(apis)

    return 0;

if __name__ == '__main__':
  sys.exit(main(sys.argv[1:]))

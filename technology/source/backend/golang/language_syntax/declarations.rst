Declarations and scope
======================

A *declaration* binds a non-blank identifier to a constant, type, variable, function, label, or package. Every identifier in a program must be declared. No identifier may be declared twice in the same block, and no identifier may be declared in both the file and package block.

Go uses lexical scoping based on code blocks to determine the visibility of identifiers:

1. The scope of a *predeclared identifier* is the **universe block**.
2. The scope of an identifier denoting a constant, type, variable, or function (but not method) declared outside any function is the **package block**.
3. The scope of the package name of an imported package is the **file block** of the file containing the ``import`` declaration.
4. The scope of an identifier denoting a method receiver, function parameter, or result variable is the **function body**.
5. The scope of a constant, type or variable identifier declared inside a function begins at the end of their declaration and ends at the end of the innermost containing block.

An identifier declared in a block may be redeclared in an inner block. While the identifier of the inner declaration is in scope, it denotes the entity declared by the inner declaration.

The ``package`` clause is not a declaration; the package name does not appear in any scope. Its purpose is to identify the files belonging to the same package and to specify the default package name for ``import`` declarations.

Blocks
------

A block is a possibly empty sequence of declarations and statements within matching brace brackets.::

    Block = "{" StatementList "}" .
    StatementList = { Statement ";"  } .

In addition to explicit blocks in the source code, there are implicit blocks:

1. The **universe block** encompasses all Go source text.
2. Each package has a **package block** containing all Go source text for that package.
3. Each file has a **file block** containing all Go source text in that file.
4. Each ``if``, ``for``, and ``switch`` statement is considered to be in its own implicit block.
5. Each clause in a ``switch`` or ``select`` statement acts as an implicit block.

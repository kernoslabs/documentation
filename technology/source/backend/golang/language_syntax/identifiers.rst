Go identifiers
==============

*Identifiers* (the names of the entities) are used to name program entities such as packages, constants, variables, types and functions. The following summarizes some attributes about identifiers in Go:

* Identifiers support the Unicode character set
* The first position of an identifier must be a letter or an underscore::

    // GO PROGRAMMING LANGUAGE SPECIFICATION

    identifier     = letter { letter | unicode_digit  } .

    letter         = unicode_letter | "_" .

    unicode_digit  = /* a Unicode code point classified as "Number, decimal digit" */ .

    unicode_letter = /* a Unicode code point classified as "Letter" */ .

* Idiomatic Go favors mixed caps (camel case) naming
* Package-level identifiers must be unique across a given package
* Identifiers must be unique within a code block (functions, control statements)

Predeclared identifiers
-----------------------

Go comes with a number of built-in identifiers. They fall into different categories and are implicitly declared in the universe block:

**Types**

+--------------+------------------------------------------------+
| Category     | Identifier                                     |
+==============+================================================+
|              | ``int8``, ``int16``, ``int32``, ``int64``      |
|              +------------------------------------------------+
|              | ``uint8``, ``uint16``, ``uint32``, ``uint64``  |
|              +------------------------------------------------+
|              | ``float32``, ``float64``                       |
| Numeric      +------------------------------------------------+
|              | ``complex64``, ``complex128``                  |
|              +------------------------------------------------+
|              | ``int``, ``uint``, ``uintptr``                 |
|              +------------------------------------------------+
|              | ``byte``, ``rune``                             |
+--------------+------------------------------------------------+
| String       | ``string``                                     |
+--------------+------------------------------------------------+
| Boolean      | ``bool``                                       |
+--------------+------------------------------------------------+
| Error        | ``error``                                      |
+--------------+------------------------------------------------+

**Values**

+----------------------+---------------------+
| Category             | Identifier          |
+======================+=====================+
| Boolean constants    | ``true``, ``false`` |
+----------------------+---------------------+
| Constant counter     | ``iota``            |
+----------------------+---------------------+
| Uninitialized value  | ``nil``             |
+----------------------+---------------------+

**Functions**

+------------------+---------------------------------------------------+
| Category         | Identifier                                        |
+==================+===================================================+
| Initialization   | ``make()``, ``new()``                             |
+------------------+---------------------------------------------------+
| Collections      | ``append()``, ``cap()``, ``copy()``, ``delete()`` |
+------------------+---------------------------------------------------+
| Complex numbers  | ``complex()``, ``imag()``, ``real()``             |
+------------------+---------------------------------------------------+
| Error Handling   | ``panic()``, ``recover()``                        |
+------------------+---------------------------------------------------+

The blank identifier
--------------------

The Go compiler is particularly strict about the use of declared identifiers for variables or packages. The basic rule is: *you declare it, you must use it*. If you attempt to compile code with unused identifiers such as variables or named packages, the compilers will not be pleased and will fail compilation.

Go allows you to turn off this behavior using the blank identifier, represented by the ``_`` (underscore) character. Any declaration or assignment that uses the blank identifier is not bound to any value and is ignored at compile time. The blank identifier is usually used in two contexts:

**Muting package imports**

When a package declaration is preceded by an underscore, the compiler allows the package to be declared without any further referenced usage.

    .. code-block:: go

        import "fmt"
        import "strings"
        import _ "log"

**Muting unwanted function results**

When a Go function call returns multiple values, each value in the return list must be assigned to a variable identifier. In some cases, however, it may be desirable to mute unwanted results from the return list while keeping others.

    .. code-block:: go

        _, execFile := filepath.Split("/opt/data.txt")

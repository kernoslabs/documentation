Variables
=========

Go is a statically typed programming language. What that means is the compiler always wants to know what the type is for every value in the program. When the compiler knows the type information ahead of time, it can help to make sure that the program is working with values in a safe way. This helps to reduce potential memory corruption and bugs, and provides the compiler the opportunity to produce more performant code.

A value’s type provides the compiler two pieces of critical information: first, the amount of memory we need to allocate (the size of the value) and second, what that memory represents. Go's types lend itself to integrity and readability.

The Go language provides these **predeclared types** that are implicitly declared in the universe block:

**Unsigned integers**
    uint8, uint16, uint32, uint64

**Signed integers**
    int8, int16, int32, int64

**Real Numbers**
    float32, float64

**Boolean**
    bool

**Integers**
    uint, int, uintptr

**String-related types**
    string, byte, rune

**Errors**
    error

Many of the previous built-in types are actually telling you both pieces of information, size and representation are part of the type’s name. A value of type ``int64`` requires 8 bytes of memory allocation (64 bits) and represents an IEEE 754 binary decimal. It is telling you everything you need to know about the cost of the variable (Again, *readability* is about understanding the cost of your decision). A ``float32`` requires 4 bytes of memory allocation (32 bits) and represents an IEEE-754 binary floating-point number. A ``bool`` requires 1 byte of memory allocation (8 bits) and represents a boolean value of ``true`` or ``false``. Even though the size is not represented in a boolean variable, you understand its cost (you know it is one byte and you know it represents ``true`` or ``false``)

Although you have the chance to declare an integer with a specific level of precision (8, 16, 32, 64), it is unsual unless you are doing things with atomic functions or things very specific. For that reason, some types get their representation based on the architecture of the machine the code is built for. A value of type ``int``, for example, can either have a size of 8 bytes (64 bits) or 4 bytes (32 bits), depending on the architecture.

You need to start with the understanding that all variables contain a value. Variables serve the purpose of assigning an *identifier* to a specific memory location for better code readability and based on the type that variable represents to help you determine how you can use it to manipulate the memory it contains. If you have a variable then you have a value in memory, and if you have a value in memory then it must have an address. In Go we can create variables that contain the "value of" the value itself or an address to the value. When the "value of" the variable is an address, the variable is considered a *pointer*.

Variable declaration
--------------------

One of Go's biggest warts is that there are too many ways to declare variables. The points below define guidelines that you can follow to provide *consistency* to your code.

1. Reserve the use of the keyword ``var`` as a way to indicate that a variable is being set to its zero value.


2. If the variable will be initialized to something other than its zero value, then use the short variable declaration operator with a struct literal. This operator is the colon with the equals sign (``:=``). The short variable declaration operator serves two purposes in one operation: it both declares and initializes a variable.

The zero-value
--------------

Go has the concept of zero value which means the value that every single variable represents, must be initialized. And if you don't specify the initialization yourselves, then it gets initilialized to its zero value. It might be one of the most important concept that Go has as zero value is a function of *integrity*.

+-------------------------------------------------------------------+--------------------------------------+
| Type                                                              | Zero-value                           |
+===================================================================+======================================+
| ``string``                                                        | "" (empty string)                    |
+------------------+------------------------------------------------+--------------------------------------+
|                  | ``int8``, ``int16``, ``int32``, ``int64``      |                                      |
|                  +------------------------------------------------+                                      |
|                  | ``uint8``, ``uint16``, ``uint32``, ``uint64``  |                                      |
| Numeric-Integers +------------------------------------------------+ 0                                    |
|                  | ``int``, ``uint``, ``uintptr``                 |                                      |
|                  +------------------------------------------------+                                      |
|                  | ``byte``, ``rune``                             |                                      |
+------------------+-----+------------------------------------------+--------------------------------------+
| Numeric-Floating point | ``float32``, ``float64``                 | 0.0                                  |
+------------------------+------------------------------------------+--------------------------------------+
| ``bool``                                                          | ``false``                            |
+-------------------------------------------------------------------+--------------------------------------+
| Interface, function, channel, slice, map and pointer              | ``nil``                              |
+-------------------------------------------------------------------+--------------------------------------+
|                                                                   | Each index position has a zero-value |
| Array                                                             | corresponding to the array's         |
|                                                                   | element type                         |
+-------------------------------------------------------------------+--------------------------------------+
| Struct                                                            | An empty ``struct`` with each member |
|                                                                   | having its respective zero-value     |
+-------------------------------------------------------------------+--------------------------------------+

Conversion versus Casting
-------------------------

Type casting is a way to convert a variable from one data type to another data type, however if you don't know what you are doing you will have an **integrity** issue. For that reason, Go does not have *casting*, what Go has is *conversion*. What Go says is if you want one byte integer to be four bytes, you are going to have to allocate another four bytes of memory. This results in a cost of an extra allocation as nothing can trump *integrity* and so *conversion* is about putting **integrity** first.

.. code-block::

    +------+
    |  10  |
    +------+
       |
       |
       v
    +------+------+------+------+
    |      |      |      |  10  |
    +------+------+------+------+

The sintax for conversion looks like a funcion call, you take the type you want to convert to (you make this "funcion call") and you pass the value in.

.. code-block:: go

    // Conversion from int to float64
    n := float64(10)

String
------

``string`` type is an important built-in type in Go. *Readability* is about being able to visualize how the code is going to run on the machine so it is important to understand the cost of using ``string`` type variables so you will see below a very special implementation detail that Go has for strings.

A ``string`` is represented in memory as a 2-word data structure. This data structure changes its size depending on the architecture so the architecture will dictate the size of this particular internal data structure. The first word represents a pointer to an array of bytes and the second word represents a length. When you don't have an array of bytes because this is an empty string, the pointer is set to ``nil`` and the integer to ``0``, technically this is set to its zero value. The internal data structure representation would be like that:

.. code-block::

    +-----+
    | nil |
    +-----+
    |  0  |
    +-----+

.. code-block:: go

    // internal structure of string
    type stringStruct struct {
        str *byte
        len int
    }

.. image:: /images/golang/01-string.png
    :width: 588px
    :height: 366px
    :align: central

.. code-block:: go

    s := "hola"
    t := s[2:3]

Because the ``string`` is inmutable, it is safe for multiple strings to share the same storage, so slicing s results in a new 2-word structure with a potentially different pointer and length that still refers to the same byte sequence. This means that slicing can be done without allocation or copying, making string slices as efficient as passing around explicit indexes.

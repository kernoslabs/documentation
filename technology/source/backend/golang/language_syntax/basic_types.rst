Basic types
===========

Go is a statically typed programming language. What that means is the compiler always wants to know what the type is for every value in the program. When the compiler knows the type information ahead of time, it can help to make sure that the program is working with values in a safe way. This helps to reduce potential memory corruption and bugs, and provides the compiler the opportunity to produce more performant code.

A value’s type provides the compiler with two pieces of information: first, how much memory to allocate --the *size of the value*-- and second, what that memory represents. In the case of many of the built-in types, size and representation are part of the type’s name. A value of type ``int64`` requires 8 bytes of memory (64 bits) and represents an integer value. A ``float32`` requires 4 bytes of memory (32 bits) and represents an IEEE-754 binary floating-point number. A ``bool`` requires 1 byte of memory (8 bits) and represents a Boolean value of ``true`` or ``false``.

Some types get their representation based on the architecture of the machine the code is built for. A value of type ``int``, for example, can either have a size of 8 bytes (64 bits) or 4 bytes (32 bits), depending on the architecture. There are other architecture specific types as well, such as all the reference types in Go. Luckily, you don’t need to know this information to create or work with values. But if the compiler doesn’t know this information, it can’t protect you from doing things that could cause harm inside your programs and the machines they run on.

Numbers
-------

The Go language provides these basic numeric types:

.. code-block::

    **Unsigned Integers**
    *uint8*, *uint16*, *uint32*, *uint64*

    **Signed Integers**
    *int8*, *int16*, *int32*, *int64*

    **Real Numbers**
    *float32*, *float64*

    **Predeclared Integers**
    *uint*, *int*, *uintptr*

The names for these keywords provide both pieces of the type information.

The uint8 contains a base 10 number using one byte of memory. The value can be between 0 to 255.

The int32 contains a base 10 number using 4 bytes of memory. The value can be between -2147483648 to 2147483647.

The predeclared integers get mapped based on the architecture you are building the code against. On a 64 bit OS, int will map to int64 and on a 32 bit OS, it will be mapped to int32.

Everything that is stored in memory comes back to one of these numeric types. Strings in Go are just a series of uint8 types, with rules around stringing those bytes together and identifying end of string positions.

A pointer in Go is of type uintptr. Again, based on the OS architecture this will be a uint32 or uint64. It is good that Go created a special type for pointers. In the old days many C programmers would write code that assumed a pointer value would always fit inside an unsigned int. With upgrades to the language and architectures over time, that eventually was no longer true. A lot of code broke because addresses became larger than the predeclared unsigned int.


Booleans
--------


Strings
-------


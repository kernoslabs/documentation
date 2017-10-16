Arrays
======

Internals
---------

An array in Go is a fixed-length data type that contains a contiguous block of element of the same type. Each element contains the same type, in this case an integer, and can be accessed through a unique index position.

.. image:: /images/golang/01-array.png

Arrays are valuable data structures because the memory is allocated sequentially. Using index arithmetic, you can iterate through all the elements of an array quickly. The type information for the array provides the distance in memory you have to move to find each element. Since each element is of the same type and follows each other sequentially, moving throught the array is consistent and fast.

Declaring and initializing
--------------------------
::

    // Declare an integer array of five elements
    var array [5]int   <>   array := [5]int{}

Once an array is declared, neither the type of data being stored nor its length can be changed.

When variables in Go are declared, they are always initialized to their zero value for their respective type, and arrays are not different. When an array is initialized, each individual element that belongs to the array is initialized to its zero value.

======= ==========
Type    Zero value
======= ==========
string  ""
int     0
pointer nil
bool    false
======= ==========

::

    // Declare an integer array of five elements.
    // Inicialize each element with a specific value.
    array := [5]int{10, 20, 30, 40, 50}

If the length is given as *...*, Go will identify the lenght of the array based on the number of elements that are inicialized.

::

    // Declare an integer array of five elements.
    // Inicialize each element with a specific value.
    // Capacity is determined based on the number of values initialized.
    array := [...]int{10, 20, 30, 40, 50}

Go allows us to inicialize specific elements of the array.

::

    // Declare an integer array of five elements.
    // Inicialize index 1 and 2 with a specific value.
    // The rest of the elements contain their zero value.
    array := [5]int{1: 10, 2: 20}

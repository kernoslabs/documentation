Slices
======

Internals
---------

Slices are tiny objects that abstract and manipulate an underlying array. They are three field data structures that contain the metadata Go needs to manipulate the underlying arrays.

.. image:: /images/golang/01-slice.png
    :align: left

The three fields are a pointer to the underlying array, the length or the number of elements the slice has access to, and the capacity or the number of elements the slice has available for growth.

Declaring and initializing
--------------------------

There are several ways to create and initialize slices in Go. Knowing the capacity you need ahead of time will usually determine how you go about creating your slice.

MAKE
^^^^

One way to create a slice is to use the built-in function ``make``. When you use ``make``, two options you have are the length and the capacity of the slice. When you just specify the length, the capacity of the slice is the same.

**Declaring a slice of strings by length**

    .. code-block:: go

        // Create a slice of strings.
        // Contains a length and capacity of 5 elements.
        slice := make([]string, 5)

**Declaring a slice of strings by length and capacity**

    .. code-block:: go

        // Create a slice of integers.
        // Contains a length of 3 and has a capacity of 5 elements.
        slice := make([]int, 3, 5)

SLICE LITERALS
^^^^^^^^^^^^^^

An idiomatic way of creating a slice is to use a slice literal. It’s similar to creating an array, except you don’t specify a value inside of the ``[ ]`` operator. The initial length and capacity will be based on the number of elements you initialize.

**Declaring a slice with a slice literal**

    .. code-block:: go

        // Create a slice of strings.
        // Contains a length and capacity of 5 elements.
        slice := []string{"Red", "Blue", "Green", "Yellow", "Pink"}

        // Create a slice of integers.
        // Contains a length and capacity of 3 elements.
        slice := []int{10, 20, 30}

When using a slice literal, you can set the initial length and capacity. All you need to do is initialize the index that represents the length and capacity you need.

**Declaring a slice with index position**

    .. code-block:: go

        // Create a slice of strings.
        // Initialize the 100th element with an empty string.
        slice := []string{99: ""}

if you specify a value inside the ``[ ]`` operator, you’re creating an array. If you don’t specify a value, you’re creating a slice.

NIL SLICES
^^^^^^^^^^

A *nil slice* is the most common way you create slices in Go. They can be used with many of the standard library and built-in functions that work with slices. They are useful when you want to represent a slice that doesn’t exist.

**Declaring a *nil* slice**

    .. code-block:: go

        // Create a nil slice of integers.
        var slice []int

    .. image:: /images/golang/02-slice.png
       :align: left

EMPTY SLICES
^^^^^^^^^^^^

You can also create an *empty slice* by declaring a slice with initialization. An *empty slice* contains a zero-element underlying array that allocates no storage. *Empty slices* are useful when you want to represent an empty collection, such as when a database query returns zero results.

**Declaring an empty slice**

    .. code-block:: go

        // Use make to create an empty slice of integers.
        slice := make([]int, 0)

        // Use a slice literal to create an empty slice of integers.
        slice := []int{}

    .. image:: /images/golang/03-slice.png
       :align: left

Working with slices
-------------------

ASSIGNING
^^^^^^^^^

*Assigning* a value to any specific index within a slice is identical to how you do this with arrays. To change the value of an individual element, use the ``[ ]`` operator.

SLICING
^^^^^^^

*Slices* are called such because you can slice a portion of the underlying array to create a new slice.

**Taking the slice of a slice**

    .. code-block:: go

        // Create a slice of integers.
        // Contains a length and capacity of 5 elements.
        slice := []int{10, 20, 30, 40, 50}

        // Create a new slice.
        // Contains a length of 2 and capacity of 4 elements.
        newSlice := slice[1:3]

    .. image:: /images/golang/04-slice.png
       :align: left

    We have two slices that are sharing the same underlying array. However, each slice views the underlying array in a different way. The original *slice* views the underlying array as having a capacity of five elements, but the view of *newSlice* is different. For *newSlice*, the underlying array has a capacity of four elements. *newSlice* can’t access the elements of the underlying array that are prior to its pointer. As far as *newSlice* is concerned, those elements don’t even exist.

**How to calculate length and capacity**

    For slice[i:j] with an underlying array of capacity k

    Length: j - i
    Capacity: k - i

If you apply this formula to *newSlice* you get the following.

**Calculating the new length and capacity**

    For slice[1:3] with an underlying array of capacity 5

    Length: 3 - 1 = 2
    Capacity: 5 - 1 = 4

Now you have two slices sharing the same underlying array. Changes made to the shared section of the underlying array by one slice can be seen by the other slice. A slice can only access indexes up to its length. Trying to access an element outside of its length will cause a runtime exception. The elements associated with a slice’s capacity are only available for growth. They must be incorporated into the slice’s length before they can be used.

.. image:: /images/golang/05-slice.png
   :align: left

GROWING SLICES
^^^^^^^^^^^^^^

Having capacity is great and Go allows you to use the built-in function ``append`` to incorporate it into your slice's length.

To use ``append``, you need a source slice and a value that is to be appended. When your ``append`` call returns, if the capacity is reached in the underlying array for a slice, it will create a new underlying array, copy the existing values that are being referenced, and provide you the new value; else it will just incorporate the available element into the slice's length and assign the value. The ``append`` function will always increase the length of the new slice. The capacity, on the other hand, may or may not be affected, depending on the available capacity of the source slice.

**Using *append* to add an element to a slice**

    .. code-block:: go

        // Create a slice of integers.
        // Contains a length and capacity of 5 elements.
        slice := []int{10, 20, 30, 40, 50}

        // Create a new slice.
        // Contains a length of 2 and capacity of 4 elements.
        newSlice := slice[1:3]

        // Allocate a new element from capacity.
        // Assign the value of 60 to the new element.
        newSlice = append(newSlice, 60)

    .. image:: /images/golang/06-slice.png
       :align: left

**Using *append* to increase the length and capacity of a slice**

    .. code-block:: go

        // Create a slice of integers.
        // Contains a length and capacity of 4 elements.
        slice := []int{10, 20, 30, 40}

        // Append a new value to the slice.
        // Assign the value of 50 to the new element.
        newSlice := append(slice, 50)

    After this ``append`` operation, newSlice is given its own underlying array, and the capacity of the array is doubled from its original size.

    .. image:: /images/golang/07-slice.png
       :align: left

Capacity is always doubled when the existing capacity of the slice is under 1,000 elements. Once the number of elements goes over 1,000, the capacity is grown by a factor of 1.25, or 25%.

THREE INDEX SLICES
^^^^^^^^^^^^^^^^^^

There’s a third index option when you are slicing. This third index gives you control over the capacity of the new slice. The purpose is not to increase capacity, but to restrict the capacity. Being able to restrict the capacity of a new slice provides a level of protection to the underlying array and gives you more control over append operations.

**Performing a three-index slice**

    .. code-block:: go

        // Create a slice of strings.
        // Contains a length and capacity of 5 elements.
        source := []string{"Apple", "Orange", "Plum", "Banana", "Grape"}

        // Slice the third element and restrict the capacity.
        // Contains a length of 1 element and capacity of 2 elements.
        slice := source[2:3:4]

    .. image:: /images/golang/08-slice.png
       :align: left

**How length and capacity are calculated**

    For slice[i:j:k]    or  [2:3:4]

    Length: j - i       or  3 - 2 = 1
    Capacity: k - i     or  4 - 2 = 2

If you attempt to set a capacity that’s larger than the available capacity, you’ll get a runtime error. By having the option to set the capacity of a new slice to be the same as the length, you can force the first append operation to detach the new slice from the underlying array. Detaching the new slice from its original source array makes it safe to change.

**Benefits of setting length and capacity to be the same**

    .. code-block:: go

        // Create a slice of strings.
        // Contains a length and capacity of 5 elements.
        source := []string{"Apple", "Orange", "Plum", "Banana", "Grape"}

        // Slice the third element and restrict the capacity.
        // Contains a length and capacity of 1 element.
        slice := source[2:3:3]

        // Append a new string to the slice.
        slice = append(slice, "Kiwi")

    Without this third index, appending *Kiwi* to our slice would’ve changed the value of *Banana* in index 3 of the underlying array, because all of the remaining capacity would still belong to the slice. But we have restricted the capacity of the slice to 1. When we call ``append`` for the first time on the slice, it will create a new underlying array of two elements, copy the fruit *Plum*, add the new fruit *Kiwi*, and return a new slice that references this underlying array,

    .. image:: /images/golang/09-slice.png
       :align: left

The built-in function ``append`` is also a variadic function. This means you can pass multiple values to be appended in a single slice call. If you use the ... operator, you can append all the elements of one slice into another.

Passing arrays between functions
--------------------------------

Passing a slice between two functions requires nothing more than passing the slice by value. Since the size of a slice is small, it’s cheap to copy and pass between functions. On a 64-bit architecture, a slice requires 24 bytes of memory. The pointer field requires 8 bytes, and the length and capacity fields require 8 bytes respectively. Only the slice is being copied, not the underlying array.

**Passing slices between functions**

    .. code-block:: go

        // Allocate a slice of 1 million integers.
        slice := make([]int, 1e6)

        // Pass the slice to the function foo.
        slice = foo(slice)

        // Function foo accepts a slice of integers and returns the slice back.
        func foo(slice []int) []int {
            ...
            return slice
        }

    .. image:: /images/golang/10-slice.png
       :align: left

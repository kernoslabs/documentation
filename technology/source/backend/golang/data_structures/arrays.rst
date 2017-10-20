Arrays
======

Internals
---------

An array in Go is a fixed-length data type that contains a contiguous block of element of the same type. Each element contains the same type, in this case an integer, and can be accessed through a unique index position.

.. image:: /images/golang/01-array.png
    :align: left

Arrays are efficient data structures because the memory is allocated sequentially. Using index arithmetic, you can iterate through all the elements of an array quickly. The type information for the array provides the distance in memory you have to move to find each element. Since each element is of the same type and follows each other sequentially, moving throught the array is consistent and fast.

Declaring and initializing
--------------------------

.. code-block:: go

    // Declare an integer array of five elements
    var array [5]int   <>   array := [5]int{}

Once an array is declared, neither the type of data being stored nor its length can be changed.

When variables in Go are declared, they are always initialized to their zero value for their respective type, and arrays are not different. When an array is initialized, each individual element that belongs to the array is initialized to its zero value.

.. table:: 
   :align: center

    ======= ==========
    Type    Zero value
    ======= ==========
    string  ""
    int     0
    pointer nil
    bool    false
    ======= ==========

.. code-block:: go

    // Declare an integer array of five elements.
    // Inicialize each element with a specific value.
    array := [5]int{10, 20, 30, 40, 50}

If the length is given as ``...``, Go will identify the lenght of the array based on the number of elements that are inicialized.

.. code-block:: go

    // Declare an integer array of five elements.
    // Inicialize each element with a specific value.
    // Capacity is determined based on the number of values initialized.
    array := [...]int{10, 20, 30, 40, 50}

Go allows us to inicialize specific elements of the array.

.. code-block:: go

    // Declare an integer array of five elements.
    // Inicialize index 1 and 2 with a specific value.
    // The rest of the elements contain their zero value.
    array := [5]int{1: 10, 2: 20}

Working with arrays
-------------------

To access an individual element, use the ``[ ]`` operator.

**Accessing array elements**

    .. code-block:: go
    
        // Declare an integer array of five elements.
        // Initialize each element with a specific value.
        array := [5]int{10, 20, 30, 40, 50}
    
        // Change the value at index 2.
        array[2] = 35
    
    .. image:: /images/golang/02-array.png
        :align: center

**Accessing array pointer elements**

    .. code-block:: go
    
        // Declare an integer pointer array of five elements.
        // Initialize index 0 and 1 of the array with integer pointers.
        array := [5]*int{0: new(int), 1: new(int)}
    
        // Assign values to index 0 and 1.
        *array[0] = 10 *array[1] = 20
    
    .. image:: /images/golang/02-array.png
        :align: center
 
You use the ``*`` operator to access the value that each element pointer points to.

An array is a value in Go. This means you can use it in an assignment operation. The variable name denotes the entire array and, therefore, an array can be assigned to other arrays of the same type. The type of an array variable includes both the length and the type of data that can be stored in each element. Only arrays of the same type can be assigned.

**Assigning one array to another of the same type**

    .. code-block:: go
    
        // Declare a string array of five elements. var array1 [5]string
        // Declare a second string array of five elements.
        // Initialize the array with colors.
        array2 := [5]string{"Red", "Blue", "Green", "Yellow", "Pink"}
    
        // Copy the values from array2 into array1.
        array1 = array2

**Assigning one array of pointers to another**

    .. code-block:: go
    
        // Declare a string pointer array of three elements.
        var array1 [3]*string
        // Declare a second string pointer array of three elements.
        // Initialize the array with string pointers.
        array2 := [3]*string{new(string), new(string), new(string)}
    
        // Add colors to each element
        *array2[0] = "Red"
        *array2[1] = "Blue"
        *array2[2] = "Green"
    
        // Copy the values from array2 into array1.
        array1 = array2

Copying an array of pointers copies the pointer values and not the values that the pointers are pointing to. After the copy, you have two arrays pointing to the same strings.

.. image:: /images/golang/04-array.png
    :align: center

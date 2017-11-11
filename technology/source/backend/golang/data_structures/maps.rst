Maps
====

A map is a data structure that provides you with an unordered collection of key/value pairs.

Internals
---------

Maps are collections, and you can iterate over them just like you do with arrays and slices. But maps are unordered collections, and there’s no way to predict the order in which the key/value pairs will be returned. Even if you store your key/value pairs in the same order, every iteration over a map could return a different order. This is because a map is implemented as a hash table.

The hash table is structured as an array of buckets. The number of buckets is always equal to a power of 2. When a map operation is performed, such as (``colors["Black"] = "#000000"``), a hash key is generated against the key that is specified. In this case the string "Black" is used to generate the hash key. The low order bits (LOB) of the generated hash key is used to select a bucket.

Once a bucket is selected, the key/value pair needs to be stored, removed or looked up, depending on the type of operation. If we look inside any bucket, we will find two data structures. First, there is an array with the top 8 high order bits (HOB) from the same hash key that was used to select the bucket. This array distinguishes each individual key/value pair stored in the respective bucket. Second, there is an array of bytes that store the key/value pairs. The byte array packs all the keys and then all the values together for the respective bucket.

    .. image:: /images/golang/01-map.png
       :align: left


Declaring and initializing
--------------------------

There are several ways you can create and initialize maps in Go.

MAKE
^^^^

One way to create a map is to use the built-in function ``make``.

**Declaring a map using a make**

    .. code-block:: go

        // Create a map with a key of type string and a value of type int.
        dict := make(map[string]int)

MAP LITERALS
^^^^^^^^^^^^

An idiomatic way of creating a map is to use a map literal.

**Declaring a map with a map literal**

    .. code-block:: go

        // Create a map with a key and value of type string.
        // Initialize the map with 2 key/value pairs.
        dict := map[string]string{"Red": "#da1337", "Orange": "#e95a22"}

The map key can be a value from any built-in or struct type as long as the value can be used in an expression with the ``==`` operator. Slices, functions, and struct types that contain slices can’t be used as map keys.

NIL MAPS
^^^^^^^^

**Declaring a *nil* slice**

    .. code-block:: go

        // Create a nil map by just declaring the map.
        var colors map[string]string

        // Add the Red color code to the map.
        colors["Red"] = "#da1337"

        Runtime Error:
        panic: runtime error: assignment to entry in nil map

EMPTY MAPS
^^^^^^^^^^

You can also create an *empty map* by declaring a slice with initialization.

**Declaring an empty map**

    .. code-block:: go

        // Create an empty map to store colors and their color codes.
        colors := map[string]string{}

        // Add the Red color code to the map.
        colors["Red"] = "#da1337"

Working with maps
-----------------

When retrieving a value from a map, you have two choices. You can retrieve the value and a flag that explicitly lets you know if the key exists.

**Retrieving a value from a map and testing existence.**

    .. code-block:: go

        // Retrieve the value for the key "Blue".
        value, exists := colors["Blue"]

        // Did this key exist
        if exists {
            fmt.Println(value)
        }

The other option is to just return the value and test for the zero value to determine if the key exists. This will only work if the zero value is not a valid value for the map.

**Retrieving a value from a map testing the value for existence**

    .. code-block:: go

        // Retrieve the value for the key "Blue".
        value := colors["Blue"]

        // Did this key exist?
        if value != "" {
            fmt.Println(value)
        }

When you index a map in Go, it will always return a value, even when the key doesn’t exist. In this case, the zero value for the value’s type is returned.

If you want to remove a key/value pair from the map, you use the built-in function ``delete``.

**Removing an item from a map**

    .. code-block:: go

        // Remove the key/value pair for the key "Coral".
        delete(colors, "Coral")

Passing arrays between functions
--------------------------------

Passing a map between two functions doesn’t make a copy of the map. In fact, you can pass a map to a function and make changes to the map, and the changes will be reflected by all references to the map.

Go source file
==============

A Go program is stored in one or more files whose names must end with the *.go* suffix. Each file begins with a ``package`` declaration that says the name of the package the source file belongs to. The Go compiler strictly enforces ``package`` declaration usage. It is considered an error (compilation) to include an unused package in your source file. The ``package`` is followed by any ``import`` declarations. The ``import`` declaration lists any external package that the source code wishes to use. The last portion of the source is considered the body of your source file. It is where you declare a sequence of *package-level* declarations of variables, constants, types, and functions.

.. code-block:: go
    
    // Package Clause
    package main

    // Import Declaration
    import (
        "fmt"
        "os"
    )

    // Source body
    type user struct {
        name    string
        surname string
    }

    func (user user) getFullName() string {
        return user.name + " " + user.surname
    }

    func main() {
        if len(os.Args) == 3 {
            user := user{
                name:    os.Args[1],
                surname: os.Args[2],
            }
            fmt.Printf("My name is %s", user.getFullName())
        }
    }

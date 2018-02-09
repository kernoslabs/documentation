Semicolons
==========

Go's formal grammar requires semicolons as statement terminators. The Go compiler breaks the input into tokens, a semicolon is automatically inserted into the token stream immediately after a line's final token (at the end of source code lines) if that token is:

* An identifier
* An integer, floating-point, imaginary, rune, or string literal
* One of the *keywords* ``break``, ``continue``, ``fallthrough``, or ``return``
* One of the *operators and punctuation* ``++``, ``--``, ``)``, ``]``, or ``}``

.. code-block:: go
    
    // Package Clause
    package main;

    // Import Declaration
    import (
        "fmt";
        "os";
    );

    // Source body
    type user struct {
        name    string;
        surname string;
    };

    func (user user) getFullName() string {
        return user.name + " " + user.surname;
    };

    func main() {
        if len(os.Args) == 3 {
            user := user{
                name:    os.Args[1],
                surname: os.Args[2],
            };
            fmt.Printf("My name is %s", user.getFullName());
        };
    };

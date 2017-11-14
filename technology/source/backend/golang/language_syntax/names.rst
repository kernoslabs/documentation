Names
=====

The names of Go functions, variables, constants, types, statement labels, and packages follow a simple rule: a name begins with a letter (anything that Unicode deems a letter) or an underscore and may have any number of additional letters, digits, and underscores. Golang is case sensitive.

If an entity is declared within a function, it is local to that function. If declared outside of a function, however, it is visible in all ﬁles of the package to which it belongs. The case of the ﬁrst letter of a name determines its visibility across package boundaries. If the name begins with an upper-case letter, it is *exported*, which means that it is visible and accessible outside of its own package and may be referred to by other parts of the program. Package names themselves are always in lower case.

Finally, the convention in Go is to use MixedCaps or mixedCaps rather than underscores to write multiword names. The letters of acronyms and initialisms like ASCII and HTML are always rendered in the same case.


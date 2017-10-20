Packages
********

In Go, source files are organized into system directories called *packages*. Every Go source file must declare the package name which it belongs to in the first line of the file (comments and whitespaces not included). Within a single folder, the package name will be same for the all source files which belong to that directory.

The naming convention for Go package is to use the name of the system directory where we are putting our Go source files. Good package names are short and clear. They are lower case, with no *under_scores* or *mixedCaps*.

Packages are found based on their relative path to the directories referenced by the environment variables **GOROOT** and **GOPATH**. Go’s standard library comes with lot of useful packages which can be used for building real-world applications. The packages from the standard library are available at the “pkg” subdirectory of the **GOROOT** directory. When you install Go, an environment variable **GOROOT** will be automatically added to your system for specifying the Go installer directory. We develop our Go programs in the **$GOPATH** directory, where we organize source code files into directories as packages. In Go packages, all identifiers will be exported to other packages if the first letter of the identifier name starts with an uppercase letter. The functions and types will not be exported to other packages if we start with a lowercase letter for the identifier name.

 * **GOROOT**: Path for standard library packages (*$GOPATH/pkg*).

 * **GOPATH**: Path for packages created by Golang developers (*$GOPATH/src*).

Package Main
============

When you build reusable pieces of code, you will develop a package as a shared library. But when you develop executable programs, you will use the package “main” for making the package as an executable program. The package “main” tells the Go compiler that the package should compile as an executable program instead of a shared library. The main function in the package “main” will be the entry point of our executable program. When you build shared libraries, you will not have any main package and main function in the package.


Import Packages
===============

The keyword *import* is used for importing a package into other packages. When you import packages, the Go compiler will look on the locations specified by the environment variable **GOROOT** and **GOPATH**. Packages from the standard library are available in the **GOROOT** location. The packages that are created by yourself, and third-party packages which you have imported, are available in the **GOPATH** location. The first place where the compiler searches for is **GOROOT**, and then it searches for in each directory listed in **GOPATH** in the order in which they were listed.

Third-Party Packages
====================

We can download and install third-party Go packages by using *go get* command. The *go get* command will fetch the packages from the source repository and put the packages on the **GOPATH** location.

Init Function
=============

When you write Go packages, you can provide a function “init” that will be called at the beginning of the execution time. The init method can be used for adding initialization logic into the package.

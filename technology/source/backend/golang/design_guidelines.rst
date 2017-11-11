Design Guidelines
=================

Software development is about designing and architecting. It is about making choices, but how can you make these choices if you don't have a philosophy in place that guides you in the right direction? You must develop a design philosophy that establishes a set of guidelines. This is more important than developing a set of rules or patterns you apply blindly. Guidelines help to formulate, drive and validate decisions. You can't begin to make the best decisions without understanding the impact of your decisions. Every decision you make, every line of code you write comes with a cost and it's never about good or bad, it's about what cost you took for what benefit you needed. This is what you have to do, this is what software engineering is all about, the cost and the benefit, not good or bad or right or wrong. But if you're not thinking about the costs of the decision you are making then you are not really architecting and designing software.


Correctness vs Performance
--------------------------

Optimizing code for performance can only be done, once you have something that is working. Don't make coding decisions based on what you think might perform better as if you are guessing, you are not making a good design choice. You must benchmark or profile to know if code is not fast enough. Then and only then you should make corrections for performance, because if you optimize for performance, you are being premature in what you are doing when you are writing code. What you need to do is optimized for correctness.

You have to write code where you can maintain a mental model of what's going on. You must constantly make sure your mental model of your projects are clear. When you can't remember where a piece of logic is or you can't remember how something works, you are losing your mental model of the code. This is a clear indication that refactoring is a must. Focus time on structuring code that provides the best mental model possible and code review for this as well.

Code review
-----------

You can't look at a piece of code, function or algorithm and determine if it smells good or bad without a design philosophy. These four major categories are the basis for code reviews and should be prioritized in this order: Integrity, Readability, Simplicity and then Performance. You must consciously and with great reason be able to explain the category you are choosing.

Integrity
^^^^^^^^^

What integrity means is that you need to become serious about writing code that is reliable. You have to take reliability seriously. There are two driving forces behind integrity:

* Integrity is about every allocation, read and write of memory that you perform being accurate, consistent and efficient, because when they're not, you have an integrity issue where you're corrupting data. **The type system is critical to making sure you have this micro level of integrity.**

* Everything you do, every problem you solve boils down to becoming a data tranformation problem. You have some input and you produce some output. Every function you write, every method you write is a data transformation. So Integrity also means that every data transformation that you have to perform must also be accurate, consistent and efficient. **Writing less code and error handling is critical to making sure we have this macro level of integrity.**

There have been studies that have researched the number of bugs you can expect to have in your software. The industry average is around 15 to 50 bugs per 1000 lines of code. One simple way to reduce the number of bugs, and increase the integrity of your software, is to **write less code**. Because when you write more code than you need, it result in *Ugly*, *Large*, and *Slow* code:

* *Ugly*: Leaves places for bugs to hide.

* *Large*: Ensures incomplete test.

* *Slow*: Encourages the use of shortcuts and dirty tricks.

When **error handling** is treated as an exception and not part of the main code, you can expect the majority of your critical failures to be due to error handling.

48 critical failures were found in a study looking at a couple hundred bugs in Cassandra, HBase, HDFS, MapReduce, and Redis.

* 92% : Failures from bad error handling

    * 35% : Incorrect handling

        * 25% : Simply ignoring an error
        * 8% : Catching the wrong exception
        * 2% : Incomplete TODOs

    * 57% System specific

        * 23% : Easily detectable
        * 34% : Complex bugs

* 8% : Failures from latent human errors

No decision you make can ever have integrity be the cost and that means **error handling** must be part of the main code that you're writing. You will see how Go puts integrity first.

Readability
^^^^^^^^^^^

Now once you write a piece of code that has integrity, then you want to make sure, optimizing for correctness, that that code is readable. What it means is that you must structure your systems to be more comprehensible. This is about writing simple code that is easy to read and understand without the need of mental exhaustion so the average developer on your team should be able to read that piece of code and have a good understanding of what it's doing logically. And, the second part, which is really critical, it's about the code that you write does not hide its cost, does not hide the cost of its impact on the program and on the machine. And we can do this in Go because we are writing code for a real machine.

Chuck Moore said "A well-designed language has a one-one correlation between source code and object code. It's obvious to the programmer what code will be generated from their source.". A well-designed language allows you to have a mental model of what's going to happen on the machine. It allows you to have this idea of readability where you can understand the choices and the impacts of your choices.

Simplicity
^^^^^^^^^^

Simplicity is about hiding complexity without loosing your ability to understand the cost of your decisions. Go does this all the time, its garbage collector hides the complexity of memory management but yet you will be able to know the choices that you make what effect you are having on the heap. So simplicity is not something you can get to day one. Readability, optimizing for correctness, yes. Simplicity is something that comes over time, it comes with refactoring, it comes with your ability to prototype, to learn, to understand and come back and hide complexity over time.

Performance
^^^^^^^^^^^

I put it last because there are times when performance is going to be your highest priority. You are going to write a piece of code and it is not going to be fast enough. This is going to happen and now, you have to make a conscious decision. You are going to walk away from simplicity, you are going to walk away from readability but you can never walk away from integrity. But now you might write a piece of code that is clever, that is a little bit complex but you have to make sure that you are doing this based on measured results. You can never guess or assume about performance. Your measurements must be relevant. You must profile to decide that something is not fast enough.

Performance is about not wasting effort. It's about being mechanically sympathetic, what it means that if performance matters, then, how code runs on the machine must matter, because we already said, it is the machine that will dictate how the performance of your software goes. Go allow you to be sympathetic. In fact, you don't even realize it, but if you follow just even some of the language idioms, they are pushing you towards mechanical sympathy. They are pushing you in the right direction.

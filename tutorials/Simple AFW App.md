@page simple-afw-app Making a simple Aurora Framework app

In this tutorial you'll learn the workflow of an Aurora Application, and how to use Aurora on your projects.

Before proceeding, make sure you already [built Aurora](@ref getting-started).

@tableofcontents

@section summary Summary

After this tutorial, you'll know how to make the equivalent of this:

```cpp
#include <iostream>

using namespace std;

int main(int agrc, char *argv[])
{
	cout << "Hello world!" << endl;

	return EXIT_SUCCESS;
}

```

using Aurora.

@section prerequisites Prerequisites

This tutorial will use the two following Aurora modules:

- aurorafw-core
- aurorafw-cli

@section writing-an-afw-app Writing an Aurora application

An Application is an app handled by Aurora to run code. You supply it the main method and arguments.

There are different types of Applications. The simplest one (and the one we're using for the tutorial) comes from the Core module, and is simply an Application.

A Graphical Application (from the GEngine module), for example, already creates a window and uses a GraphicsAPI backend, being suitable to immediately render graphics on the screen.

For now, let's bootstrap our code:

```cpp

#include <AuroraFW/Aurora.h>

using namespace AuroraFW;

Application *app;

void mainAppFunction()
{

}

int main(int argc, char *argv[])
{
	app = new Application(mainAppFunction, argc, argv);

	delete app;
	return EXIT_SUCCESS;
}
```

If you compile and run this, nothing happens yet. However, you're already using Aurora's Application class. Let's go line by line:

```cpp
#include <AuroraFW/Aurora.h>
```
This includes the Aurora.h to your program, which includes every header from the modules you're using.

```cpp
Application *app;
```
Here we define a pointer to an Application so we can define it later in the `int main()`

```cpp
void mainAppFunction()
{

}
```

This is the method that will be executed by the Application class. Here you implement the code you want.

```cpp
int main(int argc, int *argv[])
{
	...
}
```

This is the main method of your program. Here you should initialize Application and, in case you're using a pointer, delete it when it's done.

@note The `int argc, int *argv[]` arguments are optional, but it's a good pratice to include them, since Aurora uses them for it's own arguments

```cpp
app = new Application(mainAppFunction, argc, argv);
```

This is where the magic happens. Here you tell Application which method is your main method.

You can get more details by reading the documentation for AuroraFW::Application.

After your method is over, the code returns to your main method. As such, you must clean-up (in case you're using pointers):

```cpp
delete app;
return EXIT_SUCCESS;
```

So this is the basic code you must write to use Aurora. But this does not print anything. Let's use the method CLI::Log from the cli module to actually print something.

@section printing Printing something

Here we will use the CLI::Log() method to print something to the console:

```cpp
CLI::Log(CLI::Information, "Hello world!");
```

And now the code shall look like this:

```cpp

#include <AuroraFW/Aurora.h>

using namespace AuroraFW;

Application *app;

void mainAppFunction()
{
	CLI::Log(CLI::Information, "Hello world!");
}

int main(int argc, char *argv[])
{
	app = new Application(mainAppFunction, argc, argv);

	delete app;
	return EXIT_SUCCESS;
}
```

If we now run this we get some output (and also colorful!):

```
[INFORMATION] Hello world!
```

And that's it, congratulations! You just built your first Aurora Application!

You can continue to explore more tutorials or go straight to the documentation and read everything AuroraFW can do!
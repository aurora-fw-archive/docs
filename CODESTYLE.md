# Indent style

This document explains the codestyle that the Aurora Framework uses. We use this rules to keep our code spaghetti safe and with a better look.

## Aurora Codestyle Specification
<!-- TOC depthFrom:3 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Comments](#comments)
	- [Initial Comments](#initial-comments)
	- [Documentation Comments](#documentation-comments)

<!-- /TOC -->

### Comments
In Aurora code files we have a very well defined anatomy for comment blocks. You have three types of comments: the initial comments, documentation comments and code comments.

#### Initial Comments
Initial comments have general information about the file and should be present on ALL source code files. We have a boilerplate for C-like languages and languages that have `#` as 'keyword' for comment blocks. Depending on the license of the repository, you should use GPL-3.0 and LGPL-3.0 boilerplates. You can found it [here](BOILERPLATES.md).


#### Documentation Comments
To compile our documentation we use Doxygen, which uses JavaDoc Style for C-like languages and Doxygen style for other languages as a comment standard for automatically code structure detection. When you write a code file you should use this structure on header files:
```cpp
/** Example comment
 * Another comment
 *
 */
```
or this, in case of a non C-like language:
```cmake
## Example comment
# Another comment
#
```

You should use special commands to Doxygen know what you want to do with this comment. Here is some useful and most used commands:
-   `@file`
-   `@param`
-   `@return`
-   `@see`
-   `@author`

You can find the full list [here](http://www.stack.nl/~dimitri/doxygen/manual/commands.html).

For better codestyle we activated the `JAVADOC_AUTOBRIEF`, which means that you can automatically initialize a brief description ending with a first dot followed by a space or a new line. For example:
```cpp
/** Brief description which ends at this dot. Details follow
 * here.
 */
```
**Note:** Because of the aesthetics, use the brief in the first line (follow the example) whenever possible.

Here is a practical example of a documentation comment:
```cpp
/** Constructs a vector with the given coordinates.
 * @param x The x value for the x coordinate.
 * @param y The y value for the y coordinate.
 * @see Vector2D( )
 * @see Vector2D(float )
 */
```

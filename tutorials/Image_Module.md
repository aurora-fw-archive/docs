@page image-module Image Module

The Image module contains useful methods and classes to handle image files.

@tableofcontents

@section summary-image Summary

By the end of this tutorial you'll know how to read and edit images using Aurora.

Oh, and also you'll be able to do this in code:

\image html assets/image-module/image-output-alpha.png

@section prerequesites-image Prerequisites

This tutorial will use the three following Aurora modules:

- aurorafw-core
- aurorafw-image
- aurorafw-gengine-core

@section the-basics-image The basics

Firstly, we shall bootstrap our Aurora program as we did in the [previous code](@ref simple-afw-app):

```cpp

#include <AuroraFW/Aurora.h>

using namespace AuroraFW;

using namespace ImageManager;

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

(Of course, the name of vars/methods/classes doesn't need to be exactly the same as written in the tutorials)

(*Notice how we declare the usage on the ImageManager namespace. It improves the readibility of the tutorial.*)

From here on out, all the code is written in the `mainAppFunction()` (so we can use Aurora).



@section making-a-image Making the image

To create an Image object, we simply do the following:

```cpp
int width = 255;
int height = 255;
int bpp = 24;
Image myImage(FIF_PNG, "nameOfImage.png", ImageFlags::Write, width, height, bpp);
```

This code allocated space in memory for writing to a 255x255 image with a 24 bit depth.

You can check the Image's documentation to understand better the needed arguments, but, for the sake of this tutorial, we'll explain it quickly:

- `FIF_PNG` declares the [FreeImageFormat](http://graphics.stanford.edu/courses/cs148-10-summer/docs/FreeImage3131.pdf) (*page nº 13*) of the image (aka. it's extension)
- `"nameOfImage.png"` is the filename, including the extension
- `ImageFlags::Write` declares the image is only used to write.
- The rest of the arguments declare, respectively, `width, height` and `bpp` (these should only be given if the image is non existent/has only the write flag).

Now that we have the image allocated, let's write to it.

@section create-hue-image Creating the hue

To create the hue, we use the following formula:

```cpp
for(int x = 0; x < width; x++) {
	for(int y = 0; y < height; y++) {
		red = Math::clamp(y-x, 0, height);
		green = abs(y-height);
		blue = x;
	}
}
```

But how do we write these RGB values onto the image? For that, we'll use the Color class defined in the gengine-core module:

```cpp
GEngine::Color color;
```

After that, we simply apply the above formula:

```cpp
for(int x = 0; x < width; x++) {
	for(int y = 0; y < height; y++) {
		color.setRed((uint8_t)Math::clamp(y-x, 0, height));
		color.setGreen((uint8_t)abs(y-height));
		color.setBlue((uint8_t)x);

		myImage.drawPixel(x, y, color);
	}
```

The three first instructions (inside the nested for loop) simply store the RGB values to the Color object. It's in the last instruction that we ask for Aurora to write at said pixel *(x, y)* said color.

However, since this is a CLI application, we can't print the image to the console at runtime without *really* extra work. One way to see the results way easier is to simply save the image to disk.

@section saving-image Saving the image

To save the image to the disk, all you need is to call:

```cpp
myImage.saveImage();
```

This will save the image to the path previously given in the constructor (*in this case,* `nameOfImage.png`). If you go ahead and open it, you see that's... not exactly like we expected:

\image html assets/image-module/image-output.png

At the start, the image is *lighter*. But why is this? Simple: the image on the top has *alpha* values, and we defined our image's bpp to be 24 (therefore, without alpha values).

In fact, if you had noticed this in the middle of the tutorial and tried to add alpha, you may have caught **a lot** of warnings like these:

```
[WARNING] There are alpha values in the supplied color, however the image is not 32-bit.The alpha information will be lost. If you want to use alpha, first convert the image to 32-bit.```

So, let's add alpha to our image.

@section adding-alpha-image Adding alpha

There are actually two ways for your image to allow alpha values. You either:

- Declare the bpp to be 32 right in the constructor:

```cpp
int width = 255;
int height = 255;
int bpp = 32;
Image myImage(FIF_PNG, "nameOfImage.png", ImageFlags::Write, width, height, bpp);
```

Or you can also convert your image to 32 bits:

```cpp
myImage.convertTo32Bits();
```

After that, your image is ready to accept alpha values. To actually add them, just use the setAlpha() method of the Color class:

```cpp
for(int x = 0; x < width; x++) {
	for(int y = 0; y < height; y++) {
		color.setRed((uint8_t)Math::clamp(y-x, 0, height));
		color.setGreen((uint8_t)abs(y-height));
		color.setBlue((uint8_t)x);

		color.setAlpha((uint8_t)128);

		myImage.drawPixel(x, y, color);
	}
```

The alpha values go from 0 to 255, being 0 totally transparent and 255 totally opaque.

If now you change your code to add the alpha value, your image should now look exactly like the one on the start of the tutorial. Congratulations, you made your first image using Aurora!
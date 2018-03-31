@page audio-module Audio Module

The Audio module contains useful methods and classes to handle audio files.

@tableofcontents

@section summary-audio Summary

By the end of this tutorial you'll know how to play and record audio using Aurora.

@section prerequisites-audio Prerequisites

This tutorial will use the three following Aurora modules:

- aurorafw-core
- aurorafw-cli
- aurorafw-audio

@section the-basics-audio The basics

Firstly, we shall bootstrap our Aurora program as we did in the [previous code](@ref simple-afw-app):

```cpp

#include <AuroraFW/Aurora.h>

using namespace AuroraFW;

using namespace AudioManager;

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

(*Notice how we declare the usage on the AudioManager namespace. It improves the readibility of the tutorial.*)

From here on out, all the code is written in the `mainAppFunction()` (so we can use Aurora).

@section starting-backend-audio Starting the backend

Before our application has audio capabilities, we must initialize the AudioBackend. Add these two lines of code to the main method:

```cpp
AudioBackend::start();
AudioBackend::terminate();
```

If you enabled debug mode (`--afw-debug`), you will already see some output, like this:

```
[DEBUG] AudioBackend initialized. Num. of available audio devices: 16 (16 output devices, 4 input devices.)
[DEBUG] AudioBackend was terminated.
```

I already added in the `terminate()` method so I don't forget later. Now we will output some audio.

@warning Do not forget to call `terminate()` on the backend on the end of the application, so *Aurora* and *PortAudio* can deallocate it's pointers.

@section playing-debug-audio Playing a debug stream

The following code must be written between the previous `start()` and `terminate()` calls.

Even if you don't have any audio files, you can create a debug AudioOStream by leaving it's constructor empty:

```cpp
AudioOStream debugStream;
```

After that just play it:

```cpp
debugStream.play();
```

The audio playback will be executed on another thread, so we need to wait some time on the main loop. For that we use PortAudio's `Pa_Sleep()` method:

```cpp
Pa_Sleep(3000);		// 3000 miliseconds = 3 seconds
```

After we're done, we stop the stream:

```cpp
debugStream.stop();
```

Your code should now look like this:

```cpp
AudioBackend::start();

AudioOStream debugStream;
debugStream.play();

Pa_Sleep(3000);		// 3000 miliseconds = 3 seconds
debugStream.stop();

AudioBackend::stop();
```

Run it and congratulations! You made your application output some audio!

@warning Be careful, the debug wave sound is quite **loud and annoying**. Lower your volume before running the example.

@section playing-file-audio Playing a audio file

OK, you want audio capabilities to play files, and not some debug and noisy waves. We'll do just that in a minute.

If you don't have a compatible sound file (Aurora can't play .MP3 files yet), grab the `aurora-example.ogg` file [here](https://raw.githubusercontent.com/aurora-fw/app_tests_audio/master/rsrc/example.ogg).

Now, create an AudioOStream as before, but now, give it the file path:

```cpp
AudioOStream audioStream("aurora-example.ogg");
```

Now play it like before:

```cpp	
audioStream.play();
```

Before you run your code though, we need to change something: the debug stream had no end, but normal audio files have. In order to account that, let's make a simple empty loop that only stops when the audio stops:

```cpp	
while(audioStream.isPlaying()) {}
```

After that we don't even need to `stop()` the song now! The code now should look as follow:

```cpp
AudioBackend::start();

AudioOStream audioStream;
audioStream.play();

while(audioStream.isPlaying()) {}

AudioBackend::stop();
```

Enjoy your little music player!

@note The path given to the audio stream is relative to where the program is being executed.

@section recording-audio Recording audio

To record the audio, you must first create an AudioInfo structure:

```cpp
AudioInfo info;
```

Then you give it data. There's lot of things you can specify, but these 3 are always needed:

```cpp
#define SAMPLERATE 44100
...

info.setSampleRate(SAMPLERATE);
info.setChannels(2);
info.setFormat(SF_FORMAT_OGG | SF_FORMAT_VORBIS);
```

- The `setSampleRate()` defines the sample rate of the audio file. (it's generally *44.1KHz*)

- The `setChannels()` defines how many channels should the file have. (1 is mono, 2 is stereo, etc...)

- The `setFormat()` defines the format to save to. For more info, see AudioInfo's `setFormat()` documentation.

After we define the info, we open a new AudioIStream:

```cpp
AudioIStream inputStream("recording.ogg", &info, SAMPLERATE * 3); // 3 seconds of audio to record.
```

With this we allocated a buffer to hold our recording. Now we simply record:

```cpp
inputStream.record();
while(inputStream.isRecording) {}
```

The recording stops when you specifically stop it or when the buffer gets full. Now we just save it into disk:

```cpp
inputStream.save();
```

The code should now look as follow:

```cpp
#define SAMPLERATE 44100
...

AudioBackend::start();

AudioInfo info;

info.setSampleRate(SAMPLERATE);
info.setChannels(2);
info.setFormat(SF_FORMAT_OGG | SF_FORMAT_VORBIS);

AudioIStream inputStream("recording.ogg", &info, SAMPLERATE * 3); // 3 seconds of audio to record.

inputStream.record();
while(inputStream.isRecording) {}

inputStream.save();

AudioBackend::stop();
```

Run it and make any noise for 3 seconds. After that, it's saved onto the disk!

@section advanced-audio Advanced

You probably don't want to just play audio. You might want to add reverb, make it 3D, set up looping, etc...

All the already implemented features are used in the *app-tests-audio*. Check it [here](https://github.com/aurora-fw/app_tests_audio/blob/master/src/main.cpp).
# darkroomtimer
sen's Talking Darkroom Timer

Stores all steps of entire film-related processes and runs through them, giving audio and speech notifications of the required actions to be taken and how much time is remaining, enabling use with zero vision and no light required in the room.

Built to be modular and extensible, to be able to run on different hardware and with different IO/UI options with minimal porting effort. Most existing modules are built around the Raspberry Pi, as that's what the developer (sen) runs this on in their darkroom.

# Module Types
## Screen (screen)
Drives the visual output device, used to perform initial setup before the lights have to be out, and runs in parallel with audio output.
### Screen Modules
- console - Output to stdout, useful for debugging and testing.
- lcd - Output to an Adafruit Raspberry Pi LCD Hat.

## Input (input)
Accepts input, used to do initial setup before the lights are out, and to start and stop steps.
### Input Modules
- console - Receive input from stdin, useful for debugging and testing.
- gpiobuttons - Receive input from Raspberry Pi GPIOs, which will have buttons
  connected to them.

## Speech (speech)
Renders and outputs speech, which is the main output used by the timer.
### Speech Modules
- console - Output what would be speech as text on stdout, useful for debugging
  and testing when you don't want to deal with audio hardware or spend speech
  rendering credits.
- cerevoice - Render speech using the Cerevoice Cloud TTS service, free for
  light use. Since the timer pre-renders to mp3 once and uses those files forever
  after, it uses very few credits in most use cases.

## Loader (loader)
Loads process definitions into the system. Process definitions are lists of steps, how long each step should be timed for, if the user can adjust the time of that step, whether lights such as the LCD backlight are permitted during that step, etc. The format is currently the same for any of these loaders, which is a simple CSV format generated by the included process generator tool.
### Loader Modules
- files - Read process definitions from CSV files. Useful for debugging or if
  you have relatively fixed processes that don't change often, and don't want
  to have to deal with barcode hardware.
- barcode - Read process definitions from a connected serial 2D barcode reader.
  sen uses a Symbol MS4404 because there was a relatively cheap one on ebay, but
  any reader with a 'trigger' line to activate it should work with this module.

## Extension (ext)
Provide other services and functionality, used or called by the other modules.
### Extension Modules
- raspi - Provides interfacing with the Raspberry Pi's GPIO pins. This module is required by the other modules that are designed for this platform.
- wifi - Allows special wifi barcodes to be scanned to add or remove network configuration from wpa\_supplicant without needing a console or network connection into the timer.

# crrpt
A tool which can be used to hide an extra executable inside a macOS app bundle which will run invisibly at launch without impeding that application's normal function.

## How it works
Inside the directory `Application.app/Contents/MacOS`, there exists an executable binary that is used by macOS to start the given application. `_og` will be prepended to the name of this file, the payload provided will be inserted at `(...)_pl`, and a master script will replace the original executable. That script will run both the payload and the standard app simultaneously when a user launches the application.

## Syntax
```sh
./crrpt.sh payload.sh /Applications/Notes.app
```

You'll find several example payloads, using different languages, in `payloads/`. All of these payloads will simply write a file `hey` to the current user's desktop.

Note that you will need to compile some of the example payloads before using them.

## Undoing
To remove all modifications from the `.app` bundle of your choice, run:
```sh
./undo.sh /Applications/Notes.app
```

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is protected under the [MIT License](LICENSE).

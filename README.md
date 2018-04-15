# crrpt
A tool which can be used to hide an extra binary inside a `.app` file without impeding that application's normal function.

This tool allows you to insert any type of runnable binary (no longer just a bash script), which will be run invisibly when a user launches the relevant `.app` bundle.

## How it works
Formerly, the bash script of one's choice replaced the app binary (located at `(app).app/Contents/MacOS/(app)`). The original binary was renamed to `(app)_`, and a line is added to the end of the payload which launched the real binary following the script's completion.

Now, however, in order to support executables other than bash scripts and to keep everything a bit more clean, the original app binary will be renamed to `name_og`, the payload will be inserted t `name_pl`, and a master script will be written to `name` which will run both the payload and the standard app simultaneously.

## Syntax
```sh
./crrpt.sh payload.sh /Applications/Notes.app
```

You'll find several example payloads, using different languages, in `payloads/`. All of these payloads will write a file `hey` to the current user's desktop.

Note that you will need to compile some of the example payloads before using them.

## Undoing
To remove all modifications from the `.app` bundle of your choice, run:
```sh
./undo.sh /Applications/Notes.app
```

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is protected under the [MIT License](LICENSE).

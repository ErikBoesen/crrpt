# crrpt
A tool which can be used to hide a bash script inside a `.app` file without impeding that application's normal function.

## How it works
The bash script of one's choice replaces the app binary (located at `(App).app/Contents/MacOS/(App)`). The original binary is renamed to (Normal name)\_, and a line is added to the end of your bash script to launch the real binary following the script's completion.

## Syntax
```sh
./crrpt.sh payload.sh /Applications/Notes.app
```

You may use `example.sh` as a payload for an illustration of the script's function.

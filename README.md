# Wordcount - FPROG project in Haskell

## Preperation

To use the programm make sure you have installed the neccessary tools to compile and run a Haskell project:
- GHCup
- HSL
- Cabal or Stack

Follow the provided instructions:
https://www.haskell.org/get-started/


## Testing

To run the tests execute
```bash
cabal test
```

## Execute the program

To execute the program run
```bash
cabal build
```

followed by

```bash
cabal run tolstoytree-exe -- +RTS -N -s
```

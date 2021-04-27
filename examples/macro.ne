sentence[ANIMAL, PUNCTUATION] -> animalGoes[("moo" | "oink" | "baa")] $PUNCTUATION
animalGoes[SOUND] -> $ANIMAL " " $SOUND # uses $ANIMAL from its caller

main -> sentence["Cows", ("." | "!")]
# ism-virus-assignment

ASE ISM Virus/Antivirus Technologies term assignment

## What I did

1. For the initial obfuscation phase, I transformed the hardcoded hex digits into no ops via xor. So for instance:

```asm
mov ah,40H
```

became

```asm
mov ah,12H
xor ah,52H
```

because `12H xor 52H = 40H.`

It was tested and it works flawlessly, though the antivirus still detects it (albeit as a different malware variant).

![Infection](https://github.com//codepadawan93/ism-virus-assignment/blob/master/Infection.JPG?raw=true "Infection")

2. Then, I added an uncoditional jump to the start of the real code. Afterwards I added useless instructions that will be never executed.

3. Encryption

## Credits

The implementation is lifted from "The Giant Black Book of Computer Viruses" by Mark Ludwig

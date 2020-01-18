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

because 12H xor 52H = 40H.

It was tested and it works flawlessly, though the antivirus still detects it (albeit as a different malware variant).

2. Encryption

## Credits

The implementation is lifted from "The Giant Black Book of Computer Viruses" by Mark Ludwig

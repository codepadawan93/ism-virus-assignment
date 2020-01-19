ASE ISM Virus/Antivirus Technologies term assignment

What I did

1. I chose the virus mini44 because it is the simplest and easiest to debug.

2. For the initial obfuscation phase, I transformed the hardcoded hex digits into no ops via xor. So for instance:

mov ah,40H

became

mov ah,12H
xor ah,52H

because `12H xor 52H = 40H.`

It was tested and it works flawlessly,s though the antivirus still detects it (albeit as a different malware variant).

Then, I added an uncoditional jump to the start of the real code. Afterwards I added useless instructions that will be never executed.

3. Encryption

This part is a bit more convoluted. I wanted to encrypt the beginning of the instructions (the first couple of lines). I had no idea how to achieve this until I realised that I could access the instructions being run currently.

For any desired set of instructions A, I could find a set B so that each instruction in A xor KEY would yield a corresponding instruction in B (and vice versa).

I used the debugger to gain the machine code, then obtained its xor'd equivalent. I compiled it to get the instructions, but sadly some instructions were not only garbage, they prevented the code from compiling. So I was stuck here for a while.

However I realised that if I declare data in the code segment, it will be interpreted as instructions. This provided the key for my encription. I split the machine code into byte sized blocks and declared them as data. I then created a procedure to decrypt them at runtime and made sure the code still worked.

I then ran into other issues, as while the virus successfully infected other files, these would not infect anything else in turn and indeed would eventually crash the system. That was because when overwriting the target files, the initial virus wrote the decrypted instructions instead of the xor'd ones - meaning that when these other copies ran, the first thing they did was encrypt the intended instructions back into garbage. This garbage code proibably contained stuff that crashed DosBox.

I fixed the issue by re-encrypting the instructions before writing them in the copies. This is safe to do as they are never ran again after the first time. The virus now works flawlessly and has grown to 123 bytes.

According to Virus Total, a site suggested by some colleagues, it is detected by 18/56 of Antivirus software and, in some cases, correctly identified as a member of the "Trivial.44" family.

Credits

The implementation is lifted from "The Giant Black Book of Computer Viruses" by Mark Ludwig

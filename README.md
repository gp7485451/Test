# Test

This repository contains a minimal x86 boot sector that prints `Hello, world!`.

## Building

You need `nasm` installed. Assemble the boot sector with:

```bash
nasm -f bin boot.asm -o boot.bin
```

This produces `boot.bin`, a bootable 512-byte image.

## Running

You can run the image with an emulator such as QEMU:

```bash
qemu-system-x86_64 -drive format=raw,file=boot.bin
```

The emulator will display `Hello, world!` when booted.

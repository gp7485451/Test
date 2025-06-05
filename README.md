# Test

This repository contains a minimal UEFI application written in C that prints `Hello, world!` on the firmware console.

## Building

Install `gcc`, `binutils`, and `gnu-efi`:

```bash
sudo apt-get install gcc binutils gnu-efi
```

Then build the EFI binary:

```bash
gcc -I/usr/include/efi -I/usr/include/efi/x86_64 \
    -fPIC -fshort-wchar -mno-red-zone -m64 \
    -DEFI_FUNCTION_WRAPPER -c hello_uefi.c -o hello_uefi.o

ld -nostdlib -znocombreloc -T /usr/lib/elf_x86_64_efi.lds \
   -shared -Bsymbolic -L/usr/lib -lefi -lgnuefi \
   hello_uefi.o -o hello_uefi.so

objcopy -j .text -j .sdata -j .data -j .dynamic \
    -j .dynsym -j .rela -j .reloc -O binary hello_uefi.so hello_uefi.efi
```

This produces `hello_uefi.efi`, a UEFI executable.

## Running

You can run the application with QEMU and OVMF:

```bash
qemu-system-x86_64 -drive format=raw,file=fat:rw:. \
    -bios /usr/share/OVMF/OVMF_CODE_4M.fd \
    -net none -serial mon:stdio
```

When the UEFI shell prompt appears, execute:

```
fs0:\\hello_uefi.efi
```

The program prints `Hello, UEFI world!` and waits for a key before exiting, providing a simple example terminal interaction.

# Boot Process: Kernel

Now that the bootloader has passed on the necessary parameters, let's dive into how the kernel gets started:

## Initrd vs Initramfs

There is a bit of a chicken and egg problem when it comes to kernel bootup. The kernel manages the system's hardware, but not all drivers are available to the kernel during the boot process. So, we depend on a temporary root filesystem that contains only the essential modules the kernel needs to access the rest of the hardware.

In older versions of Linux, this task was handled by the **initrd** (initial ram disk). The kernel would mount the initrd, load the necessary bootup drivers, and once everything was ready, it would replace the initrd with the actual root filesystem.

These days, we use **initramfs**, which is a temporary root filesystem built into the kernel itself. This approach eliminates the need to locate an initrd file and allows the kernel to load all the necessary drivers for the real root filesystem.

## Mounting the Root Filesystem

At this point, the kernel has all the modules it needs to create a root device and mount the root partition. However, before proceeding, the root partition is mounted in **read-only mode** to allow **fsck** (filesystem consistency check) to run and verify the system's integrity. Afterward, the root filesystem is remounted in **read-write mode**.

Finally, the kernel locates the **init program** (typically `/sbin/init`) and executes it to begin the user-space initialization process.

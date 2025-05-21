###########
> Linux file system hierarchy structure may vary depending on the distribution, the following hierarchy reflects the standard structure of the file system.
<img src="https://farukguler.com/assets/post_images/fs.png" alt="alt text" width="380" height="230">

```sh

/: Known as the root directory. The entire file system starts at this point.
/bin: This directory contains the basic system programs that users use to manage the system. For example, commands such as ls, cp, rm are located in this directory.
/boot: This directory contains the files required for system startup. Items such as the boot loader, kernel, and startup configuration files are located in this directory.
/dev: This directory contains device files. Each hardware device or virtual device is represented as a file in this directory. For example, hard disks can be represented as /dev/sda, /dev/sdb.
/etc: This directory contains system configuration files. For example, files such as network settings, user accounts, and service configurations are located in this directory.
/home: This directory contains users' personal files and directories. Each user usually has a subdirectory with the same name.
/lib: This directory contains the basic system libraries. Common libraries used by programs are located in this directory.
/media: This directory is a point for portable media devices. For example, CD or USB drives can be automatically mounted in this directory.
/mnt: This directory contains temporarily mounted file systems. When another file system is temporarily mounted in this directory, its content can be viewed in this directory.
/opt: This directory contains optional software packages. Software that is not integrated with the system or is installed separately can be found in this directory.
/proc: This directory contains kernel and process information such as running processes and system information. It represents a special file system and contains virtual files instead of real files.
/root: This directory is the personal directory for the system administrator (root). Unlike the personal directories of other users, a separate directory is created for the root user. "Not to be confused with the root "/" directory at the top of the file system."
/run: This directory contains runtime data. For example, the PID files of running processes can be found in this directory.
/sbin: This directory contains basic programs for system administration. Similar to the programs in the /bin directory, but they are usually only available to the root user.
/srv: This directory contains data related to the server. For example, server documentation or databases for a web server can be kept in this directory.
/sys: This directory contains information about the Linux kernel. It provides a virtual representation of hardware devices, drivers, and kernel parameters.
/tmp: This directory contains temporary files. Temporary data and processes used by programs can be stored in this directory.
/lost+found: Recovered files. This directory holds the bits of files that are damaged or have been interrupted due to an interruption.
/usr: This directory has a separate hierarchy containing secondary programs, libraries, and documentation. For example, applications installed by users and secondary programs that come with the system can be found in this directory.
/var: This directory contains variable data. For example, log files, databases, email, and other variable data can be found in this directory.

```

# File Ownership

In Linux and other UNIX-based operating systems, every file is associated with a **user** who is the **owner**. Every file is also associated with a **group** (a subset of all users) which has an interest in the file and certain rights, or permissions: **read**, **write**, and **execute**.

The following utility programs involve user and group ownership and permission setting.

---

## Commands and Usage

| **Command** | **Usage**                                                                 |
|-------------|---------------------------------------------------------------------------|
| `chown`     | Used to change user ownership of a file or directory                      |
| `chgrp`     | Used to change group ownership                                            |
| `chmod`     | Used to change the permissions on the file, which can be done separately for owner, group and the rest of the world (often named as *other*) |


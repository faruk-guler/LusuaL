# How to Check Swap Space

There are several ways to check swap space in Linux.

- The **free** command with the -h tag shows the total, available, and used swap space in a human-readable format.

```shell
$ free -h
```

- The **/proc/meminfo** file shows the total, free, and used swap space in kilobytes.

```shell
$ cat /proc/meminfo | grep Swap
```

- The **/proc/swaps** file shows active swap devices.

```shell
$ cat /proc/swaps
```

- The **swapon** command with the --show tag displays swap information. The output shows the active swap devices, including the path, file type, size, and usage.

```shell
$ swapon --show
```

To monitor swap space, use a monitoring tool such as the vmstat command.

# How to View a Swap File on Linux

To view the contents of a swap file, use the **strings** command and save the contents to another file.

```shell
$ sudo strings /swapfile > output.txt
```

# How to Create a New Swap File on Linux

Creating a swap file on Linux is a simple process.

## Create Storage File

Use the **dd** tool to create a new storage file.

```shell
$ sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
```

The command contains the following parameters:

- **if=/dev/zero** is the input file. The /dev/zero file is a special file that returns as many null characters as a read operation requests.
- **of=/swapfile** is the output swap storage file. The common practice is to place the file in the root directory.
- The **bs** parameter is the block size.
- The **count** parameter determines how many blocks to copy.

The total data size is **bs*count**, which in this case is 2GB.

## Set Swap Permissions

Set the swap file permissions to root read and write.

```shell
$ sudo chmod 600 /swapfile
```

The command shows no output. Check the permissions with the following:

```shell
$ ls / | grep swapfile
```

## Set Up Swap Area

The swap file requires formatting the reserved file size into a swap area.

```shell
$ sudo mkswap /swapfile
```

The command formats the swap file into a swap space and outputs the size, label, and UUID.

## Enable Swap

Enable the swap area for use.

```shell
$ sudo swapon /swapfile
```

Verify the swap is active.

```shell
$ swapon --show
```

The output shows a list of swapping devices and files, including the newly created swap file.

## Persist Swap

The swap file does not persist after a restart by default. To make the changes permanent:

1. Open the /etc/fstab file with a text editor.

```shell
$ sudo vim /etc/fstab
```

2. Append the swap information in the following format.

```shell
/swapfile swap swap defaults 0 0
```

3. Save the file and close the editor.

# How to Adjust Swappiness on Linux

Swappiness determines how often a Linux system uses the swap space. The swappiness value is a number between 0 and 200.

1. To check the current system swappiness value, run:

```shell
$ cat /proc/sys/vm/swappiness
```

The command prints a number between 0 and 200. A low value avoids swapping, while a high value increases swap usage.

2. To change the swappiness value to 10, run:

```shell
$ sudo sysctl vm.swappiness=10
```

The optimal value depends on the system, workload, and memory usage. Production servers typically require lower values.

3. To persist the change after a restart, open the `/etc/sysctl.conf` file:

```shell
$ sudo vim /etc/sysctl.conf
```

4. Append the following information to the file:

```shell
vm.swappiness = 10
```

5. Save the file and close vim.

# How to Remove a Swap File on Linux

Removing a swap file requires deactivating the swap space before removal.

1. To deactivate the swap, run:

```shell
$ sudo swapoff -v /swapfile
```

2. Use the **rm** command to delete the swap file:

```shell
$ sudo rm /swapfile
```

3. Open the `/etc/fstab` file:

```shell
$ sudo vim /etc/fstab
```

4. Remove the following swap information.

```shell
/swapfile swap swap defaults 0 0
```

5. Save the file and close vim.

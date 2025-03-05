## SystemV (SysV)

The main purpose of init is to start and stop essential processes on the system. There are three major implementations of init in Linux, System V, Upstart and systemd. In this lesson, we're going to go over the most traditional version of init, System V init or Sys V (pronounced as 'System Five').

To find out if you are using the Sys V init implementation, if you have an /etc/inittab file you are most likely running Sys V.

Sys V starts and stops processes sequentially, so let's say if you wanted to start up a service named foo-a, well before foo-b can work, you have to make sure foo-a is already running. Sys V does that with scripts, these scripts start and stop services for us, we can write our own scripts or most of the time use the ones that are already built in the operating system and are used to load essential services.

The pros of using this implementation of init, is that it's relatively easy to solve dependencies, since you know foo-a comes before foo-b, however performance isn't great because usually one thing is starting or stopping at a time.

When using Sys V, the state of the machine is defined by runlevels which are set from 0 to 6. These different modes will vary depending on the distribution, but most of the time will look like the following:

0: Shutdown
1: Single User Mode
2: Multiuser mode without networking
3: Multiuser mode with networking
4: Unused
5: Multiuser mode with networking and GUI
6: Reboot

When your system starts up, it looks to see what runlevel you are in and executes scripts located inside that runlevel configuration. The scripts are located in /etc/rc.d/rc[runlevel number].d/ or /etc/init.d. Scripts that start with S(start) or K(kill) will run on startup and shutdown, respectively. The numbers next to these characters are the sequence they run in.

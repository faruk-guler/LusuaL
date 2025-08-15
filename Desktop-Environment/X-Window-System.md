# X Window System

Loading the graphical desktop is one of the final steps in the boot process of a Linux desktop. Historically, this was known as the **X Windows System**, often just called **X**.

A service called the **Display Manager** keeps track of the displays being provided and loads the **X server** (so-called, because it provides graphical services to applications, sometimes called **X clients**). The display manager also handles graphical logins and starts the appropriate desktop environment after a user logs in.

X is rather old software; it dates back to the **mid-1980s** and, as such, has certain deficiencies on modern systems (for example, with **security**), as it has been stretched rather far from its original purposes. A newer system, known as **Wayland**, is gradually superseding it and is the **default display system** for **Fedora**, **RHEL**, and other recent distributions. 

For the most part, it looks just like X to the user, although under the hood it is quite different.

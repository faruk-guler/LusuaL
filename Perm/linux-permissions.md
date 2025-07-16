---
layout: post
title: Linux Permissions Management [File and Directory]
date: 2024-07-12 21:24
tag: [Permit]
author: theguler
comments: true
categories: [Linux / Unix]
---
<!-- wp:image {"id":3342,"width":"502px","height":"auto","aspectRatio":"1.1710526315789473","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/perm.jpg?w=1024" alt="" class="wp-image-3342" style="aspect-ratio:1.1710526315789473;width:502px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>Linux,</strong> as a multi-user operating system, provides comprehensive permission and authorization systems to ensure file and directory security. These permissions determine who can access files and directories and what types of operations this access covers. In this article, we will examine file and directory permissions in Linux in detail and with examples.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong><mark style="background-color:rgba(0, 0, 0, 0)" class="has-inline-color has-blue-color">#Ownership:</mark></strong><br>Every file or directory is assigned <strong>(3)</strong> types of owner:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul class="wp-block-list"><!-- wp:list-item -->
<li><strong>Owner: </strong>the owner is the user who created the file or directory.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>Group:</strong> a group can have multiple users. All users in the group have the same permissions to access the file or directory.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>Other:</strong> other means those users who are not owners or members of the group.</li>
<!-- /wp:list-item --></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p><strong><mark style="background-color:rgba(0, 0, 0, 0)" class="has-inline-color has-blue-color">#Permission:</mark></strong><br>There are only three <strong>(3)</strong> types of permissions for a file or directory:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul class="wp-block-list"><!-- wp:list-item -->
<li><strong>Read (r):</strong> can read the contents of a file. Can list files and directories.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>Write (w):</strong> the write permission allows the user to change the content of the file.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>Execute (x):</strong> the execute permission allows a file to be executed.&nbsp;</li>
<!-- /wp:list-item --></ul>
<!-- /wp:list -->

<!-- wp:image {"id":14095,"width":"502px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/chmod.png?w=864" alt="" class="wp-image-14095" style="width:502px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>Types of files:</strong></p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul class="wp-block-list"><!-- wp:list-item -->
<li><strong>- </strong>Regular (Normal) file</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>d</strong> Directory</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>b</strong> Special block file</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>c</strong> Special character file</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>l</strong> Symbolic link file</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>P</strong> Special named pipe file</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>s</strong> Socket file</li>
<!-- /wp:list-item --></ul>
<!-- /wp:list -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>✅Example: -rwxr-xr-- </strong>"manage.php"</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p><strong>sudo ls -alh</strong> manage.php</p>
<!-- /wp:paragraph -->

<!-- wp:table {"hasFixedLayout":false} -->
<figure class="wp-block-table"><table><tbody><tr><td>-</td><td><strong>rwxr-xr--</strong></td><td>1 </td><td>root </td><td>helpdesk</td><td>580</td><td>Jul 24 x.x</td><td><strong>manage.php</strong> / <strong>lib -&gt; usr/lib</strong></td></tr><tr><td><strong>type:</strong></td><td><strong>permission:</strong></td><td><strong>connection:</strong></td><td><strong>owner:</strong></td><td><strong>group:</strong></td><td><strong>size:</strong></td><td><strong>last set:</strong></td><td><strong>name/link:</strong></td></tr></tbody></table></figure>
<!-- /wp:table -->

<!-- wp:table {"hasFixedLayout":false} -->
<figure class="wp-block-table"><table><tbody><tr><td class="has-text-align-left" data-align="left"><strong>Permission</strong></td><td> <strong>rwx</strong></td><td> <strong>r-x</strong></td><td> <strong>r--</strong></td></tr><tr><td class="has-text-align-left" data-align="left"><strong>Access Rights</strong></td><td> (Owner)</td><td> (Group)</td><td> (Others)</td></tr></tbody></table><figcaption class="wp-element-caption"><mark style="background-color:rgba(0, 0, 0, 0);color:#eb210a" class="has-inline-color"><strong><em>– Regular (Normal) file phrase is removed in this </em>table</strong></mark></figcaption></figure>
<!-- /wp:table -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong># Directory and File Permissions: [/ERP - manage.php ]</strong><br>chmod 750 /ERP # (permissions change)<br>chmod 640 manage.php # ('')<br><br><strong>&gt;&gt;Change:</strong> (Owner) &amp; (Group)<br>chown zafer /ERP # (owner change)<br>chown faruk manage.php # ('')<br>chown faruk:helpdesk manage.php (owner+group change)<br>chgrp helpdesk /ERP # (group change)<br>chgrp zafer manage.php # ('')<br><br><strong># Status: [/ERP - manage.php ]</strong><br>ls -alh [/ERP or manage.php]<br>ls -ald /ERP<br>ls -ald manage.php<br>stat -c "%a %n" manage.php <strong>#Numeric</strong><br><br><strong># /ERP directory Perm:</strong><br>drwxr-x--- 2 root zafer 4096 Jul 30 12:08 <strong>/ERP/</strong><br>✦ (owner): Read, write and execute (rwx)<br>✦ (group): Read and execute (r-x)<br>✦ (others): No permissions (---)<br><br><strong># manage.php file Perm:</strong><br>-rw-r----- 1 faruk faruk 0 Jul 29 06:55 <strong>manage.php</strong><br>✦ (owner): Can read and write (rw-) the file, but cannot execute it.<br>✦ (group): The file can be read (r--), but cannot be executed or written.<br>✦ (others): Cannot access the file at all (---)<br><br><strong># Recursive Permissions:</strong><br>chmod -R 755 &lt;dir&gt; or &lt;file&gt;<br><br><strong>&gt;Mass Recursive:</strong><br>find /path/to/directory -type f -exec chmod 644 {} \;<br>find /path/to/directory -type d -exec chmod 755 {} \;<br><br><strong># Change attribute: </strong>Immutable flag: (Lock/Unlock)<br><strong>#</strong>sudo chattr +i /etc/passwd<br><strong>#</strong>sudo chattr -i /etc/passwd<br><br><strong>#What is Umask?</strong><br>Umask <strong>(user file creation mode mask)</strong> is a command that controls the default permissions of newly created files and directories in Unix and Linux-based operating systems. umask determines which permissions are removed when a new file or directory is created. The umask setting lasts for the duration of the session and is lost when the shell is closed. You can make it permanent.<br><br><strong>For Files:</strong> The default permissions are set to <strong>666 (rw-rw-rw-)</strong><br><strong>For Directories:</strong> The default permissions are set to <strong>777 (rwxrwxrwx)</strong><br><br>$umask #check<br>$umask -S<br>$umask 022 #Temporary change command<br><br><strong>#UMASK Persistent:</strong><br>sudo nano /etc/profile (only users)<br>sudo nano /etc/bash.bashrc (all users)</pre>
<!-- /wp:preformatted -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>u</strong>     file/directory owner<br><strong>g</strong>     Users in the same group as the file/directory owner<br><strong>o </strong>    Other users than the file/directory owner<br><strong>a</strong>     Everyone<br><strong>s </strong>    SUID bit (Set User ID) &gt; Special Feature<br><strong>s </strong>    SGID bit (Set Group ID) &gt; Special Feature<br><strong>t</strong>     STICKY bit &gt; Special Feature<br><br><strong>+     Adding permission<br>–     Delete permission</strong><br><strong>=     Permission equalization</strong> (Removes other permissions for Access Rights)<br><br><strong>##Example: </strong>Granting access rights to [myscript.sh]<br>(owner) : rwx (7)<br>(group) : r-x (5)<br>(other) : –x  (1)<br><br><strong>&gt;Numeric:</strong><br>chmod 751 myscript.sh<br><br><strong>&gt;Symbolic</strong><br># chmod u + rwx myscript.sh<br># chmod g +r-x myscript.sh<br># chmod o +--x myscript.s</pre>
<!-- /wp:preformatted -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>##File and Directory Permissions Examples: [Remove and Assign]</strong><br><br><strong>Owner Execution Permission:</strong><br>chmod u+x myscript.sh<br>chmod u+x /ERP<br><br><strong>Remove read and write permissions for Group and Other:</strong><br>chmod go –rw myscript.sh<br>chmod go-rw /ERP<br><br><strong>Remove Write Permission for a Group:</strong><br>chmod g-w myscript.sh<br>chmod g-w /ERP<br><br><strong>Grant read permission to the owner and remove all other permissions:</strong><br>chmod u=r myscript.sh<br>chmod u=r /ERP<br><br><strong>Remove Other Read Permission:</strong><br>chmod o-r myscript.sh<br>chmod o-r /ERP<br><br><strong>Granting Execute permission to a Group:</strong><br>chmod g+x myscript.sh<br>chmod g+x /ERP<br><br><strong>Recursively Remove Read and Write Permission for Group and Other:</strong><br>chmod –R go-rw myscript.sh<br>chmod -R go-rw /ERP</pre>
<!-- /wp:preformatted -->

<!-- wp:image {"id":14084,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://farukguler.com/assets/post_images/perm_lnx.png?w=1024" alt="" class="wp-image-14084" /></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul class="wp-block-list"><!-- wp:list-item -->
<li><strong><code>r--</code></strong> → <code><strong>4</strong></code></li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong><code>r-x</code></strong> → <code><strong>5</strong></code> (4 + 1)</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong><code>rw-</code></strong> → <code><strong>6</strong></code> (4 + 2)</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong><code>rwx</code></strong> →<strong> <code>7</code></strong> (4 + 2 + 1)</li>
<!-- /wp:list-item --></ul>
<!-- /wp:list -->

<!-- wp:image {"id":14161,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://farukguler.com/assets/post_images/dense.png?w=1024" alt="" class="wp-image-14161" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>💡 You can also use File Manager tools to visually edit permissions.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>ACL (Access Control List)</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>A feature used in Unix and Unix-like operating systems to control access to files and directories. ACLs provide <strong>more</strong> granular and flexible access control than basic file permissions.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":14219,"width":"420px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/acls.jpg?w=900" alt="" class="wp-image-14219" style="width:420px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>SELinux (Security-Enhanced Linux)</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>SELinux (Security-Enhanced Linux) is a security module integrated with the Linux kernel. It was first developed by the US National Security Agency<strong> (NSA) </strong>and released as open source. SELinux provides more detailed and configurable access control to increase security in Linux operating systems. <a href="https://tr.wikipedia.org/wiki/SELinux">https://tr.wikipedia.org/wiki/SELinux</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>Stay hungry to be learn</strong></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

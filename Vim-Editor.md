# Vim Essentials: A Comprehensive Cheat Sheet

> Unlock the power of Vim with these essential commands and tips!

## 𝐕𝐢𝐦 (𝐕𝐢 𝐈𝐦𝐩𝐫𝐨𝐯𝐞𝐝) 𝐂𝐡𝐞𝐚𝐭𝐬𝐡𝐞𝐞𝐭

- Why to learn Vi?
  - Vi is almost always available. Absolute necessary and good to know for pentesting.
  - Vi is lightweight and fast.

- `vi` : Starting Vi

```
~
~
~                         VIM - Vi Improved
~
~                          version 8.0.707
~                     by Bram Moolenaar et al.
~            Vim is open source and freely distributable
~
~                     Sponsor Vim development!
~          type  :help sponsor<Enter>    for information
~
~          type  :q<Enter>               to exit
~          type  :help<Enter>  or  <F1>  for on-line help
~          type  :help version8<Enter>   for version info
~
~                   Running in Vi compatible mode
~          type  :set nocp<Enter>        for Vim defaults
~          type  :help cp-default<Enter> for info on this
~
~
```

## 🚀 **Basic Cursor Movement (Normal/Visual Mode)**

- **Arrow keys**: `h j k l`  
  Move left, down, up, and right.
- **Word movement**:  
  `w` - Move to next word  
  `b` - Move to previous word  
  `W` - Move to next space-separated word  
  `B` - Move to previous space-separated word  
- **End of word**:  
  `e` - Move to end of current word  
  `ge` - Move to previous end of word  
- **Line movement**:  
  `0` - Move to the start of the line  
  `$` - Move to the end of the line  
  `^` - Move to the first non-blank character of the line

---

## ✂️ **Editing Text**

- **Insert Mode**:  
  `i` - Start insert mode at the cursor  
  `a` - Start insert mode after the cursor  
  `I` - Start insert mode at the beginning of the line  
  `A` - Start insert mode at the end of the line  
  `o` - Add a blank line below  
  `O` - Add a blank line above  
- **Exit Insert Mode**:  
  `Esc` or `Ctrl + [`  
- **Delete**:  
  `d` - Delete  
  `dd` - Delete the current line  
  `c` - Delete, then start insert mode  
  `cc` - Delete the line, then start insert mode

---

## ⚙️ **Operators (Works in Visual Mode)**

- **Text manipulation**:  
  `d` - Delete from cursor to movement location  
  `c` - Delete and start insert mode  
  `y` - Copy from cursor to movement location  
  `>` - Indent one level  
  `<` - Unindent one level  
- **Example**: `d$` - Deletes from the cursor to the end of the line.

---

## 📑 **Marking Text (Visual Mode)**

- **Start Visual Mode**:  
  `v` - Start visual mode (character-wise)  
  `V` - Start line-wise visual mode  
  `Ctrl + v` - Start block visual mode  
- **Exit Visual Mode**:  
  `Esc` or `Ctrl + [`

---

## 📝 **Clipboard Operations**

- **Yank (Copy)**:  
  `yy` - Yank a line  
  `p` - Paste after the cursor  
  `P` - Paste before the cursor  
- **Cut**:  
  `dd` - Delete (cut) a line  
  `x` - Delete (cut) the current character  
  `X` - Delete (cut) the previous character

---

## 💻 **Exiting Vim**

- `:w` - Save the file  
- `:wq` - Save and quit  
- `:q` - Quit (fails if anything has changed)  
- `:q!` - Quit without saving changes

---

## 🔍 **Search & Replace**

- **Search Forward**:  
  `/pattern` - Search for `pattern`  
  `?pattern` - Search backward for `pattern`  
  `n` - Repeat search in the same direction  
  `N` - Repeat search in the opposite direction  
- **Replace**:  
  `:%s/old/new/g` - Replace all occurrences of `old` with `new`  
  `:%s/old/new/gc` - Replace with confirmation

---

## 🔄 **Undo & Redo**

- `u` - Undo the last action  
- `Ctrl + r` - Redo the last undone action

---

## 🎯 **Advanced Cursor Movement**

- **Scroll**:  
  `Ctrl + d` - Scroll down half a page  
  `Ctrl + u` - Scroll up half a page  
- **Paragraph Navigation**:  
  `}` - Move forward by paragraph  
  `{` - Move backward by paragraph  
- **Go to specific locations**:  
  `gg` - Go to the top of the page  
  `G` - Go to the bottom of the page  
  `: [num]` - Go to a specific line number  
  `Ctrl + e` / `Ctrl + y` - Scroll up/down one line

---

## 🧑‍💻 **Character Search**

- `f [char]` - Move forward to the given character  
- `F [char]` - Move backward to the given character  
- `t [char]` - Move forward to just before the given character  
- `T [char]` - Move backward to just before the given character  
- `;` / `,` - Repeat search forwards/backwards

---

## 🔧 **Editing Text (Advanced)**

- **Join Lines**: `J` - Join the line below to the current line  
- **Replace Character**: `r [char]` - Replace a single character with the specified character  

---

## 🔲 **Visual Mode Tips**

- **Move to other corners**:  
  `O` - Move to the other corner of a block  
  `o` - Move to the other end of the marked area

---

## 📁 **File Tabs & Window Management**

- **File Operations**:  
  `:e filename` - Edit a file  
  `:tabe` - Open a new tab  
- **Tab Navigation**:  
  `gt` - Go to the next tab  
  `gT` - Go to the previous tab  
- **Window Splitting**:  
  `:vsp` - Vertically split windows  
  `Ctrl + ws` - Split windows horizontally  
  `Ctrl + wv` - Split windows vertically  
  `Ctrl + ww` - Switch between windows  
  `Ctrl + wq` - Quit a window

---

## 🔖 **Marks (Jump Between Points)**

- **Setting Marks**:  
  `m{a-z}` - Set mark `{a-z}` at the cursor position  
  `'{a-z}` - Jump to the start of the line where the mark was set  
  `''` - Jump back to the previous location

---

## 🧑‍💻 **Text Objects (Advanced Editing)**

- **Text Object Example**:  
  `di(` - Delete everything inside the parentheses (without leaving the parentheses).  
  `di{` - Deletes inside curly braces `{}`.

---

## ⚡ **General Commands**

- **Repeat Last Command**: `.`  
- **Reselect Last Selection**: `gv`  
- **Jump Between Matching Parentheses**: `%`

---

## ⚙️ **Customizing Vim for Maximum Efficiency**

Vim can be a bit difficult to master out of the box, but with the right configuration, it becomes incredibly powerful. Here are a few tips:

### 🚀 **Make Vim More Usable**:
- **Switch Caps Lock and Escape**:  
  Switch the Caps Lock key with the Escape key for a more comfortable experience.

### 💻 **Integrate Vim with Your IDE**:
- **VSCode**:  
  Install the Vim extension for a great Vim experience in Visual Studio Code.
- **Sublime Text**:  
  Use the `Vintageous` plugin for Vim mode inside Sublime Text.

---

## 📂 **Using the System Clipboard**

If you want to copy/paste between Vim and other applications, use:

- `"+y` - Yank to system clipboard  
- `"+p` - Paste from system clipboard

Make sure your Vim is built with the clipboard option (`+clipboard`), which you can check by running `vim --version`. If it's not enabled, you may need to install Vim with the clipboard option.

---

### 🚨 **Other Useful Commands**:

- **Quit all buffers**: `:qa`  
- **Write all buffers**: `:wa`  
- **Write and quit all buffers**: `:wqa`

---

With this cheat sheet, you can unlock Vim's true potential and make your editing experience faster and more efficient. Happy editing! 🎉

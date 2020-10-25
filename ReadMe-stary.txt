------------------------------------------------------------------------
LBA Package Editor - editing hqr, ile, obl, vox packages from Little Big Adventure 1 & 2
Version 0.01 beta
Author: zink@poczta.onet.pl - any feedback is welcome

Sorry about my English ;)
------------------------------------------------------------------------

 Contents:

 1. What is this program for?
 2. Manual
  2.1. Interface
  2.2. Opening archives
  2.3. Replacing files inside archives
  2.4. Compiling into new archive
  2.5. Creating and using script files
 3. What should I do step-by-step?

---------------------------------------------
 1. What is this programme for?
---------------------------------------------

 Generally it allows editing package files. These files are used in LBA 1 and 2 for storing pallettes, 3D models, images, sprites, and more types of data. HQR files are comtainers of other files, which are inside them like in the ZIP file, but without directories. Some files inside one HQR file may be compressed, some may be not. Sometimes files in one archive are repeated. It means that there is only one copy of them, but they occur more than one time in file header. Sometimes there are blank files: files, that phisically doesn't exist (they have zero size), but they are in file header too. It causes the files which contain repeated and blank files can't be modified by without keeping their original structure. Those files won't be working properly in the game. This programme allows you to simply replace some files inside any HQR file without changing it's structure. For detailed specification of HQR files consult help file in LBADeComp (you can download it form http://www.magicball.net). 
 This proramme cannot unpack files from archives! If you want to do this, use El-Muerte's LbaDeComp (you can download it from www.magicball.net).
---------------------------------------------
 2. Manual
---------------------------------------------

 2.1. Interface
--------------------
 At the top of main screen there is the text box with small button on the right, that is used to open HQR files.
 On the left there is a list of files inside opened HQR file, and on the right there is file manager.
 At the bottom there are some buttons. They are: 
  <Choose output HQR> - before creating changed HQR file you must specify the path where the file will be saved to.
  <COMPILE> - Save changed HQR file to a new file.
  <Cancel changes> - Undoes all changes you have made to current HQR file. 
  <Save to script> - Saves all changes to script file.
  <Run script> - Executes saved script file.
  <Replace> - Repalces currently selected file on the left by currently selected file in the file manager on the right.
  <UnReplace> - Undoes currently selected file in HQR file list back to the old one.

 2.2. Opening archives
---------------------------
 Click at the button with three points at the top right corner of the window, and select the file you want to open. This file will be loaded into memory and it's content will be displayed in the list on the left. You can cancel loading file by clicking <Stop> button in the center of file list, but then you will only be able to look through it's content. In that case no editing will be available.
 After loading you will see some of files details in the list. They are:
  "Nr" - position of file in archive
  "Offset" - number of bytes the file is shifted by from file beginnig, position of file in archive
  "Orig. size" - original (unpacked) size of file in bytes
  "Packed" - size the file has in packed state
  "C/T" - is for "Copression/Type". Compression can be 0, 1 and 2. They mean: 0 - no compression, 1 - file is compressed using Lba1 compression mode, 2 - file is compressed using Lba2 compression mode. In Lba1 HQR files some files are compressed with mode 1 and some uncompressed, in Lba2 some files are uncompressed, some are compressed with mode 1 and some with mode 2. Type means type of file. It can be: N - normal file, B - blank file - this file doesn't exist and it can't be replacd by any other one, R:X - repeated file, X describes the number of file that is repeated here - only one of them exists in real, the other are only links to it.
  "Replace with" - path to file that will replace this file in archive.

 When you click some files in the list, you'll see that they are marked by + on the left. Sometimes not only the selected file is marked, but also oter ones. It means that they are the same file (the next files are repetitions of the firs one). If you try to replace one of them, the path will appear at the all of them. You cannot replace these files with two or more different files, because they appear in one copy only phisically in the HQR file and because of keeping the original file structure.

 2.3. Replacing files inside archives
--------------------------------------------
 Select the file you want to replace in file list on the left. Select the file from file manager that will replace that file. Then click <Replace> to make the change. The path to file from file manager will appear in the right column of the list. If you want the current file form HQR file list not to be replaced during compilation, select it, and click <UnReplace>. 
 To replace files you can also drag a file from file manager and drop it over the file you want to replace.
 Clicking the "Cancel chganges" button will clear all "Replace with" fields in filelist.

 2.4. Compiling into new archive
--------------------------------------
 After you make all changes you wanted, click "Choose output HQR" and choose the path and type the file name. After that click the "Compile" button. It will write the content of original HQR file to the new one, replacing files you set to be replaced from main programme window. The new files aren't compressed, but even if you will replace a compressed one, the HQR will work still OK.

 2.5. Creating and using script files
----------------------------------------
 You can make the script file for faster do the HQR files when you are editing one of the files form the HQR and you want to test it often during editing. In the script are saved: path to current HQR file, path to destination HQR file, and paths to files that will replace original files with the indexes of files they have to replace. For example if you are editing second text file from text.hqr, you just have to open original text.hqr file with HQR Manager, replace the second file with the edited one, chhose the destination file and save the compilation to script file by clicking "Save to script" button. When you want to update the text.hqr with the edited file, you will only have to click "Run script" button and select the script file. The programme will open the text.hqr file, replace the second file with the edited one and save it to chosen hqr file. And it will be done completely automatically. You only have to remember to keep the files to compilation in the directories they were during creating the script. After clicking "Run script" the summary window will appear. You can see the compilation details, start compilation or choose only to show the file by clicking "Load only". This last option will only load HQR file and set the replacing files - the file will not be compiled, so you can make changes to it before compiling.

----------------------------------------------------
 3. What should I do step-by-step?
----------------------------------------------------

 1. Open HQR file you want to edit by clicking the small button in the top right corner of the window.
 2. Choose file from file list (on left) to be replaced.
 3. Choose file from file manager that will replace the one from file list.
 4. Click "Replace button" or drag-and-drop the file.
 5. Repeat 2-4 for all files you want to replace in HQR.
 6. Click "Choose output HQR" button and choose the the path and name for new HQR.
 7. Click "Compile" button and enjoy :).
------------------------------------------------------------------------
LBA Package Editor
 editing hqr, ile, obl, vox packages from Little Big Adventure 1 & 2

     Version: 0.11
Release date: 08.09.2005
      Status: Freeware (GNU GPL license).
      E-mail: zink@poczta.onet.pl - any feedback is welcome
   Home page: www.emeraldmoon.prv.pl

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details (License.txt).
------------------------------------------------------------------------

### About entry info feature (and entries extensions), for history see filedesc.txt:

 All information is taken from LBA File Information Project (Started by ChaosFish).
 The main page of the Project is: http://www.magicball.net/forum/showthread.php?t=7488
 The following people worked hard to get the information (in random order):
  
  ChaosFish
  Telanis
  yaz0r
  AlexFont
  El Muerte
  O_Brasilo

 And I want to express my thanks to them. Thanks people.
   
------------------------------------------------------------------------

Full manual is coming (no, not soon, but it's coming ;))

Sections of this file:
 1. Future plans.
 2. I need help.
 3. Known issues.


####################################
 1. Future plans
####################################

 It would be good to find a job, and get married, and... oh... sorry
 
 Here are the plans about Package Editor:
  
 - Full manual in hlp or chm format
 - File format descriptions (also as hlp or chm) 
 - Extracting entries just by dragging them from main window to Explorer (does anyone know how to do it in Delphi or C++?)
 - Searching entries by info text.
 - Adding and deleting hidden entries
 - Converting between normal<->repeated entries


 Any ideas are welcome.

####################################
 2. I need help
#################################### 
 
 If you know how to code the following things I will appreciate if you share your knowledge with me:

 - How to make such thing: I drag something from an application window, then I drop it onto Explorer window and application get the path where I dropped it. Such thing is made in WinRar: you can drag a file and drop it onto a window, and it then unpacks thie file(s) into the directory that was displayed in that window. I will understand it even if it is in C++.


####################################
 3. Known issues
#################################### 

 ### The program doesn't say that a file was changed after editing it with Hex Workshop (and sometimes with other programs).
 >>> Hex Workshop doesn't change file's date/time during saving (don't ask, I don't know why), so Package Editor thinks that the file was not changed. You may also sometimes experience this with other programs, if a new thread (that waits until tool execution ends) couldn't be created for some reason (e.g. lack of memory).

 ### LBADeComp's "LBA Viewer" doesn't display the image, when I open some entry with it. 
 >>> I think "LBA Viewer" has a bug, it only put file path into the path box, so you just have to click on "Reload" button (in LBA Viewer) and it works fine.
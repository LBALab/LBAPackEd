# LBA Package Editor

This program can edit resource files from the Little Big Aventure 1 and 2 games. 

Resource files are files with four extensions: 
 - HQR - High Quality Resource - contain various types of resources: scenery construction data, pictures, textures, sounds, music, dialogue texts, 3D objects, animation sequences and video clips
 - VOX - contain audio files for dialogues (character voices)
 - ILE - LBA 2 only, contain island construction data (3D)
 - OBL - LBA 2 only, contain island objects (3D)
 
(In this program the resource files are called 'packages') 

Format of the four types is essentially the same. They are containers for multiple smaller files containing various types of data. The particular data file (called 'entry') is referenced by its position (index) inside the resource file.

The entries can be 'repeated' - meaning the particular data exists under two or more index positions, but the actual data is stored only once in the resource file, thus saving disk space. For example a particular background image may be used in two places in the game. These two places have different index references for the image, and could have two distinct images, but if the second indice is a 'repeated entry' of the first one, the same image will be used foor both.

The entries can be compressed. The compression algorithm used is a variant of LZSS. There are two slightly different compression algorithms:
 - LBA 1 uses compression type 1 only - it is slightly less effective than type 2
 - LBA 2 uses primarily type 2, which compresses better, but type 1 is also used for some files

This program is released under GNU GPL license.


## Known issues

 - The program doesn't say that a file was changed after editing it with Hex Workshop (and sometimes with other programs). Hex Workshop doesn't change file's date/time during saving (don't ask, I don't know why), so Package Editor thinks that the file has not been changed. You may also sometimes experience this with other programs, if a new thread (that waits until tool execution ends) couldn't be created for some reason (e.g. lack of memory).

 - _LBADeComp's 'LBA Viewer' won't display the image, when I open some entry with it_ - I think it's LBA Viewer's issue. It only puts the file path into the path box without actually opening it, so you just have to click on 'Reload' button (in LBA Viewer) and it will work fine.
 
## Special thanks

Information about entries (extensions and content) comes from LBA File Information Project (Started by ChaosFish and continued in [LBA FileInfo Wiki](http://lbafileinfo.kaziq.net/index.php/Main_Page). Its content has been gathered and described by many people, most notably: ChaosFish, Telanis, yaz0r, AlexFont, El Muerte, O_Brasilo. Many thanks to them.

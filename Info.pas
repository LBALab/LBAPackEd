//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// Info unit.
// Contains routines used for prividing information about entries.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit Info;

interface

uses SysUtils, Graphics, Forms, Math, ExtractDlg, StdCtrls, StrUtils;

{File indexes:
 (these indexes are integers, they are split into two numbers anly for better orientation)
 ("nr" means file number, "v" means file version (LBA 1 or 2 and other))

  nr v
  00 0: Unknown file

  00 1: ress.hqr from LBA1
  00 2: ress.hqr from LBA2

  01 1: scene.hqr from LBA1
  01 2: scene.hqr from LBA2

  02 1: text.hqr from LBA1
  02 2: text.hqr from LBA2

  03 0: samples.hqr from LBA1 demo version (or diskette version ?)
  03 1: samples.hqr from LBA1 normal version
  03 2: samples.hqr from LBA2

  04 1: sprites.hqr from LBA1
  04 2: sprites.hqr from LBA2

  05 1: body.hqr from LBA1
  05 2: body.hqr from LBA2

  06 1: anim.hqr from LBA1
  06 2: anim.hqr from LBA2

 following files occur in LBA1 only:

  070: lba_bll.hqr
  071: lba_brk.hqr
  072: lba_gri.hqr
  073: midi.hqr
  074: file3d.hqr
  075: invobj.hqr
  076: flasamp.hqr
  077: fla_gif.hqr (diskette versions only)
  078: fla_pcx.hqr (some diskette versions only)

 following files occur in LBA2 only:

  080: anim3ds.hqr
  081: lba2.hqr
  082: lba_bkg.hqr
  083: holomap.hqr
  084: spriraw.hqr
  085: objfix.hqr
  086: video.hqr
  087: screen.hqr
  088: scrshot.hqr (demo version only)

 following files occur with ile and obl extension:
 (numbers in "ile" column mean the indexes of files with "ile" extension, and so on)

             ile  obl
    ascence  100  200
   celebra2  101  201
   celebrat  102  202
    citabau  103  203
    citadel  104  204
     desert  105  205
   emeraude  106  206
     ilotcx  107  207
    knartas  108  208
       moon  109  209
   mosquibe  110  210
   otringal  111  211
   platform  112  212
  sousceleb  113  213

 following files have vox extensions ("xx" means language):

                LBA 1            LBA 2
            en   fr   de     en   fr   de
  xx_000:  300  400  500    600  700  800
  xx_001:  301  401  501    601  701  801
  xx_002:  302  402  502    602  702  802
  xx_003:  303  403  503    603  703  803
  xx_004:  304  404  504    604  704  804
  xx_005:  305  405  505    605  705  805
  xx_006:  306  406  506    606  706  806
  xx_007:  307  407  507    607  707  807
  xx_008:  308  408  508    608  708  808
  xx_009:  309  409  509    609  709  809
  xx_010:  310  410  510    610  710  810
  xx_011:   -    -    -     611  711  811
  xx_gam:  399  499  599    699  799  899

  *** end ***}

{extensions:
  0: ldc, lun - unknown - no editor necessary
  1: lim - image
  2: pal - palette
  3: lbt - text
  4: lsp - sprite
  5: lsr - raw sprite
  6: lm1 - LBA 1 3D model
  7: lm2 - LBA 2 3D model
  8: lfn - font
  9: wav - wave
 10: voc - creative voice
 11: smk - smacker movie
 12: xmi - x-midi
 13: anm - animation file
 14: gif - graphics image
 15: lsh - shape file
 16: ls1 - LBA 1 scene
 17: ls2 - LBA 2 scene
 18: brk - brick fil
 19: bl1 - LBA 1 brick layouts library
 20: bl2 - LBA 2 brick layouts library
 21: gr1 - LBA 1 grid file
 22: gr2 - LBA 2 grid file
 23: grf - LBA 2 grid fragment file
 24: pcx - ZSoft paintbrush

 To add an extension you have to update:
  - Extensions constant, GetExt, GetDescription, ExtToIndex functions,
     and, if necessary, extension arrays in Info.pas,
  - add icon to Images image list on the main form,
  - dOpenReplace and dSaveEntry dialogs (filters) on the main form,
  - items in cExt combo box on fExtract form,
  - tools list on ToolsForm (don't forget about the names!),
  - StrArray and BoolArray types, DefaultNames and MaxExt constants in Tools.pas}

const
 ress1: array[0..53] of Byte = (2,8,0,0,0,2,0,1,0,6,6,6,1,2,1,1,2,1,2,1,
  2,6,2,0,2,1,2,1,2,6,13,6,13,6,13,6,13,6,13,6,13,6,13,6,13,6,13,6,13,1,2,0,1,2);
 ress2: array[0..48] of Byte = (2,8,0,0,0,0,1,7,0,2,2,1,0,1,1,1,1,1,1,1,
  1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,0,0,15,0,0);
 holomap: array[0..45] of Byte = (0,0,1,0,1,0,1,0,1,1,7,7,0,8,8,0,0,0,1,
  0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0);

 Extensions: array[0..24] of String[3] = ('lun','lim','pal','lbt','lsp',
  'lsr','lm1','lm2','lfn','wav','voc','smk','xmi','anm','gif','lsh','ls1',
  'ls2','brk','bl1','bl2','gr1','gr2','grf','pcx');

 inf_colour: array[0..23] of TColor =
  (clBlack, clRed, clMaroon, clMaroon, clGreen, clTeal, clBlue, clBlue, clOlive,
   clNavy, clPurple, clMaroon, clTeal, clOlive, clGreen, clTeal, clNavy, clNavy,
   clOlive, clMaroon, clMaroon, clGreen, clGreen, clGreen);

var
  EntryInfo: array of String;
  InfoLoaded: Boolean = False;
  PackName: String;
  PackIndex: Integer = 0;
  UnknownPack: Boolean = True;
  BkgInfo: array[0..4] of Word;

function GetExt(index: Integer): Byte;
function GetDispExt(index: Byte): String;
function ExtToIndex(ext: String): Byte;
function GetDescription(ext: Byte): String;
Procedure LoadInfoFile;
Function IsNorm(Index: Integer): Boolean;
Function IsBlank(Index: Integer): Boolean;
Function IsRep(Index: Integer): Boolean;
Function IsHidden(Index: Integer): Boolean;

implementation

uses LBAPackEd1, files, DePack;

function NameFCount(Name: String; Count: Integer; Count2: Integer = -1): Boolean;
begin

 Result:=AnsiContainsText(PackName,Name) and ((FCount=Count) or (FCount=Count2));
end;

function NameNorm(Name: String; Count: Integer; Count2: Integer = -1): Boolean;
begin
 Result:=AnsiContainsText(PackName,Name) and ((Norm=Count) or (Norm=Count2));
end;

Procedure GetFileIndex;
var ext: String;
    buff: Integer;
begin
 PackName:=LowerCase(ExtractFileName(Form1.InLabel.Caption));
 ext:=ExtractFileExt(PackName);
 PackIndex:=0;
 If ext='.hqr' then begin
  If NameFCount('ress',54) then PackIndex:=001
  else if NameFCount('ress',49) then PackIndex:=002
  else if NameFCount('scene',120) then PackIndex:=011
  else if NameFCount('scene',223) then PackIndex:=012
  else if NameFCount('text',140) then PackIndex:=021
  else If NameFCount('text',180) then PackIndex:=022
  else if NameFCount('samples',196) then PackIndex:=030
  else If NameFCount('samples',243) then PackIndex:=031
  else if NameFCount('samples',895) then PackIndex:=032
  else if NameFCount('sprites',118) then PackIndex:=041
  else If NameFCount('sprites',425) then PackIndex:=042
  else if NameFCount('body',132) then PackIndex:=051
  else If NameFCount('body',469) then PackIndex:=052
  else if NameFCount('anim',516) then PackIndex:=061
  else If NameFCount('anim',2083) then PackIndex:=062
  else if NameFCount('lba_bll',134) then PackIndex:=070
  else if NameFCount('lba_brk',8715) then PackIndex:=071
  else if NameFCount('lba_gri',134) then PackIndex:=072
  else if NameFCount('midi',33) then PackIndex:=073
  else if NameFCount('file3d',82) then PackIndex:=074
  else if NameFCount('invobj',28) then PackIndex:=075
  else if NameFCount('flasamp',67) then PackIndex:=076
  else if NameFCount('fla_gif',19) then PackIndex:=077
  else if NameFCount('fla_pcx',19) then PackIndex:=078
  else if NameFCount('anim3ds',128) then PackIndex:=080
  else if NameFCount('lba2',1) then PackIndex:=081
  else if AnsiContainsText(PackName,'lba_bkg')
       and (Entries[0].RlSize=28) then PackIndex:=082
  else if NameFCount('holomap',46) then PackIndex:=083
  else if NameFCount('spriraw',167) then PackIndex:=084
  else if NameFCount('objfix',105) then PackIndex:=085
  else if NameFCount('video',34) then PackIndex:=086
  else if NameFCount('screen',78) then PackIndex:=087
  else if NameFCount('scrshot',22) then PackIndex:=088;
 end
 else if (ext='.ile') or (ext='.obl') then begin
  If NameFCount('ascence',9,36) then buff:=00
  else if NameFCount('celebra2',9,24) then buff:=01
  else if NameFCount('celebrat',9,14) then buff:=02
  else if NameFCount('citabau',57,115) then buff:=03
  else if NameFCount('citadel',57,86) then buff:=04
  else if NameFCount('desert',117,106) then buff:=05
  else if NameFCount('emeraude',27,30) then buff:=06
  else if NameFCount('ilotcx',9,14) then buff:=07
  else if NameFCount('knartas',21,92) then buff:=08
  else if NameFCount('moon',27,30) then buff:=09
  else if NameFCount('mosquibe',21,54) then buff:=10
  else if NameFCount('otringal',45,151) then buff:=11
  else if NameFCount('platform',27,106) then buff:=12
  else if NameFCount('souscelb',21,21) then buff:=13;
  If ext='.ile' then PackIndex:=buff+100 else PackIndex:=buff+200;
 end
 else if ext='.vox' then begin
  If NameNorm('000',191) then buff:=00
  else if NameNorm('001',268) then buff:=01
  else if NameNorm('002',44) then buff:=02
  else if NameNorm('003',117) then buff:=03
  else if NameNorm('004',34) then buff:=04
  else if NameNorm('005',44) then buff:=05
  else if NameNorm('006',39) then buff:=06
  else if NameNorm('007',66) then buff:=07
  else if NameNorm('008',18) then buff:=08
  else if NameNorm('009',36) then buff:=09
  else if NameNorm('010',13) then buff:=10
  else if NameNorm('gam',31,28) then buff:=99   //*** end of LBA1 ***
  else if NameNorm('000',347) then buff:=300
  else if NameNorm('001',1) then buff:=301
  else if NameNorm('002',293) then buff:=302
  else if NameNorm('003',40) then buff:=303
  else if NameNorm('004',258) then buff:=304
  else if NameNorm('005',59) then buff:=305
  else if NameNorm('006',84) then buff:=306
  else if NameNorm('007',29) then buff:=307
  else if NameNorm('008',42) then buff:=308
  else if NameNorm('009',8) then buff:=309
  else if NameNorm('010',5) then buff:=310
  else if NameNorm('011',16) then buff:=311
  else if NameNorm('gam',47) then buff:=399;
  If AnsiContainsText(PackName,'en') then PackIndex:=buff+300
  else if AnsiContainsText(PackName,'fr') then PackIndex:=buff+400
  else if AnsiContainsText(PackName,'de') then PackIndex:=buff+500
  else PackIndex:=000;
 end;
 UnknownPack:=PackIndex=0;
end;

function GetExt(index: Integer): Byte; //index counts all entries (start with 0)
begin
 Result:=0;
 case (PackIndex div 100) of
  1: If (index=1) or (index=2) then Result:=1 else Result:=0;  //.ile
  2: Result:=7;        //.obl       (*.lm2)
  3, 4, 5: Result:=10; //.vox LBA1  (*.voc)
  6, 7, 8: Result:=9;  //.vox LBA2  (*.wav)
  0: case (PackIndex div 10) of
      0: case PackIndex of         //ress
          1: Result:=ress1[index];
          2: Result:=ress2[index];
         end;
      1: case (PackIndex mod 10) of   //scene
          1: Result:=16;      //  (*.ls1)
          2: Result:=17;      //  (*.ls2)
         end;
      2: If Odd(index) then Result:=3 else Result:=0;  //text  (*.lbt)
      3: case (PackIndex mod 10) of   //samples
          0, 1: Result:=10;   //  (*.voc)
          2: Result:=9;       //  (*.wav)
         end;
      4: Result:=4;    //sprites  (*.lsp)
      5: case (PackIndex mod 10) of   //body
          1: Result:=6;       //  (*.lm1)
          2: Result:=7;       //  (*.lm2)
         end;
      6: Result:=13;   //anim     (*.anm)
      7: case (PackIndex mod 10) of
          0: Result:=19;   //lba_bll  (*.bl1)
          1: Result:=18;   //lba_brk  (*.brk)
          2: Result:=21;   //lba_gri  (*.gr1)
          4: Result:=0;    //file3d   (*.lun)
          3: Result:=12;   //midi     (*.mid)
          5: Result:=6;    //invobj   (*.lm1)
          6: Result:=10;   //flasamp  (*.voc)
          7: If index=0 then Result:=0 else Result:=14;  //fla_gif  (*.gif)
          8: If index=0 then Result:=0 else Result:=24;  //fla_pcx  (*.pcx)
         end;
      8: case (PackIndex mod 10) of
          0, 1: Result:=0;        //anim3ds, lba2  (*.lun)
          2: If (index>=BkgInfo[0]) and (index<BkgInfo[1]) then Result:=22  //lba_bkg  (*.gr2)
             else if (index>=BkgInfo[1]) and (index<BkgInfo[2]) then Result:=23   // (*.grf)
             else if (index>=BkgInfo[2]) and (index<BkgInfo[3]) then Result:=20   // (*.bl1)
             else if (index>=BkgInfo[3]) and (index<BkgInfo[3]+BkgInfo[4]) then Result:=18 // (*.brk)
             else Result:=0;
          3: Result:=holomap[index]; //holomap
          4: Result:=5;              //spriraw  (*.lsr)
          5: Result:=7;              //objfix   (*.lm2)
          6: Result:=11;             //video    (*.smk)
          7, 8: If Odd(index) then Result:=2 else Result:=1; //screen, scrshot (*.lim, *.pal)
         end;
     end;
 end;
end;

function GetDispExt(Index: Byte): String;
begin
 If Index=0 then Result:='' else Result:=Extensions[Index];
end;

function ExtToIndex(ext: String): Byte;
begin
 If ext='lim' then Result:=1
 else If ext='pal' then Result:=2
 else If ext='lbt' then Result:=3
 else If ext='lsp' then Result:=4
 else If ext='lsr' then Result:=5
 else If ext='lm1' then Result:=6
 else If ext='lm2' then Result:=7
 else If ext='lfn' then Result:=8
 else If ext='wav' then Result:=9
 else If ext='voc' then Result:=10
 else If ext='smk' then Result:=11
 else If ext='xmi' then Result:=12
 else If ext='anm' then Result:=13
 else If ext='gif' then Result:=14
 else If ext='lsh' then Result:=15
 else If ext='ls1' then Result:=16
 else If ext='ls2' then Result:=17
 else If ext='brk' then Result:=18
 else If ext='bl1' then Result:=19
 else If ext='bl2' then Result:=20
 else If ext='gr1' then Result:=21
 else If ext='gr2' then Result:=22
 else If ext='grf' then Result:=23
 else if ext='pcx' then Result:=24
 else Result:=0;
end;

function GetDescription(ext: Byte): String;
begin
 case ext of
   1: Result:='LBA image';
   2: Result:='Palette file';
   3: Result:='LBA text file';
   4: Result:='LBA sprite';
   5: Result:='LBA Raw sprite';
   6: Result:='LBA 1 3D model';
   7: Result:='LBA 2 3D model';
   8: Result:='LBA font file';
   9: Result:='Riff wave file';
  10: Result:='Creative voice file';
  11: Result:='Smacker movie';
  12: Result:='XMidi file';
  13: Result:='LBA animation file';
  14: Result:='Graphics interchange format';
  15: Result:='LBA shape file';
  16: Result:='LBA 1 scene';
  17: Result:='LBA 2 scene';
  18: Result:='LBA brick file';
  19: Result:='LBA 1 layouts library';
  20: Result:='LBA 2 layouts library';
  21: Result:='LBA 1 grid file';
  22: Result:='LBA 2 grid file';
  23: Result:='LBA 2 grid fragment';
  24: Result:='ZSoft paintbrush';
  else Result:='unknown file';
 end;
end;

//               Entry Info
//----------------------------------------------------------------------------

Procedure ReadBkgInfo;
var S: String;
    a: Integer;
begin
 If (Length(Entries)<1) or (Entries[0].RlSize<>28) then Exit;
 If Entries[0].Comp=0 then S:=Entries[0].Data else Unpack(0,S);
 for a:=0 to 4 do
  BkgInfo[a]:=Byte(S[a*2+1])+Byte(S[a*2+2])*256;
end;

Procedure LoadInfoFile;
var FileName, temp: String;
    f: TextFile;
    a, b, c, d: Integer;
    vox_num: Boolean;
begin
 InfoLoaded:=False;
 vox_num:=False;
 SetLength(EntryInfo,0);
 SetLength(EntryInfo,Norm+Hidden+Rep+1);
 EntryInfo[0]:='>>> info file not found <<<';
 GetFileIndex;
 If PackIndex=082 then ReadBkgInfo;
 FileName:=Copy(PackPath,1,Length(PackPath)-3)+'hqd';
 If not FileExists(FileName) then begin
  case PackIndex of
   000: EntryInfo[0]:='>>> unrecognized file <<<';
   001: temp:='ress1';
   002: temp:='ress2';
   011: temp:='scene1';
   012: temp:='scene2';
   021: temp:='text1';
   022: temp:='text2';
   030: temp:='samples0';
   031: temp:='samples1';
   032: temp:='samples2';
   041: temp:='sprites1';
   042: temp:='sprites2';
   051: temp:='body1';
   052: temp:='body2';
   061: temp:='anim1';
   062: temp:='anim2';
   070: temp:='lba_bll';
   071: temp:='lba_brk';
   072: temp:='lba_gri';
   073: temp:='midi';
   074: temp:='file3d';
   075: temp:='invobj';
   076: temp:='flasamp';
   077: temp:='fla_gif';
   078: temp:='fla_pcx';
   080: temp:='anim3ds';
   081: temp:='lba2';
   082: temp:='lba_bkg';
   083: temp:='holomap';
   084: temp:='spriraw';
   085: temp:='objfix';
   086: temp:='video';
   087: temp:='screen';
   088: temp:='scrshot';
   100, 200: temp:='ascenc';
   101, 201: temp:='celeb2';
   102, 202: temp:='celeb';
   103, 203: temp:='citaba';
   104, 204: temp:='citade';
   105, 205: temp:='desert';
   106, 206: temp:='emerau';
   107, 207: temp:='ilotcx';
   108, 208: temp:='knarta';
   109, 209: temp:='moon';
   110, 210: temp:='mosqui';
   111, 211: temp:='otring';
   112, 212: temp:='platfo';
   113, 213: temp:='sousce';
  end;
  case (PackIndex div 100) of
   1: temp:=temp+'_i';
   2: temp:=temp+'_o';
   3, 4, 5, 6, 7, 8: {If (FIndex mod 100)<>99 then} begin
    b:=1;
    d:=0;
    for a:=0 to FCount-1 do begin
     If not IsHidden(a) then Inc(d);
     If IsNorm(a) then begin
      If IsHidden(a+1) then begin
       EntryInfo[b]:=Format('Voice for text item %d, part 1',[d]);
       c:=2;
      end
      else EntryInfo[b]:=Format('Voice for text item %d',[d]);
     end;
     If IsHidden(a) then begin
      EntryInfo[b]:=Format('Voice for text item %d, part %d',[d,c]);
      Inc(c);
     end;
     If IsNorm(a) or IsHidden(a) then Inc(b);
    end;
    temp:='vox'+IntToStr(IfThen((PackIndex div 100)<6,1,2))+'_all';
    vox_num:=True;
    InfoLoaded:=True;
   end;
  end;
  {case PackIndex of
   399: FileName:='vox1_en';       //en_gam             (28 normal entries)
   499, 599: FileName:='vox1_df';  //de_gam and fr_gam  (32 normal entries)
   699, 799, 899: FileName:='vox2_gam';
  end;}
  FileName:=ExtractFilePath(Application.ExeName)+'filedesc\'+temp+'.hqd';
 end; 
 If FileExists(FileName) then begin
  AssignFile(f,FileName);
  FileMode:=fmOpenRead;
  Reset(f);
  If vox_num then
   for a:=0 to IfThen((PackIndex mod 100)<99,PackIndex mod 100,13) do
    ReadLn(f,EntryInfo[0])
  else
   for a:=0 to Length(EntryInfo)-1 do
    ReadLn(f,EntryInfo[a]);
  CloseFile(f);
  InfoLoaded:=True;
 end;
end;

//----------------------------------------------------------------------------

Function IsNorm(Index: Integer): Boolean;
begin
 Result:=Entries[Index].FType=-1;
end;

Function IsBlank(Index: Integer): Boolean;
begin
 Result:=Entries[Index].FType=-2;
end;

Function IsRep(Index: Integer): Boolean;
begin
 Result:=Entries[Index].FType>-1;
end;

Function IsHidden(Index: Integer): Boolean;
begin
 Result:=Entries[Index].FType=-3;
end;


end.

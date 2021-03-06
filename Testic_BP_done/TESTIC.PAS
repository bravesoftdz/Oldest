Program Test_program;
Uses Crt, Graph;
Var GraphDetect, GraphMode : integer;
    MaxX, MaxY,
    result,             { ������⢮ ���࠭��� �窮� }
    MaxTest,            { ��饥 �᫮ ����ᮢ }
    TestTip : integer;  { ��� ����� = 1..4 }
    MaxN,i,j : integer;
    N : array [1..8,1..3] of integer; { ���ᨢ �ᥫ ��� ����ᮢ }
    F : FILE of char;                 { ���� � ����묨 ��� ����ᮢ }
    text : string;

{ ��楤�� ������ 䠩�� }
Procedure OpenFile(FileName : string);
 Begin
  {$I-}
  Assign(F, FileName);
  Reset(F);
  if IOResult<>0 then
  begin
    writeln('�訡�� ������ 䠩�� ������ ',FileName);
    Halt(1);
  end;
  {$I+}
 End;

{ ��楤�� ���뢠��� �� ᨬ���쭮�� 䠩�� �᫠ }
Function ReadFromFile : integer;
 Var a : char;
     ret : integer;
 Begin
  a:=' ';
  ret:=0;
  { ���� �� ��⠫� �� 䠩�� ����... }
  while (Ord(a)<48) OR (Ord(a)>57) do
    read(F,a);
  { ���뢠�� �� 䠩�� �� ����� ���騥 ���� - �� �ॡ㥬�� �᫮ }
  repeat
    ret:=ret*10;
    ret:=ret+(Ord(a)-48);
    read(F,a);
  until (Ord(a)<48) OR (Ord(a)>57);
  ReadFromFile:=ret;
 End;

Procedure Music(n : integer);
 Var i : integer;
 Begin
  case n of
   0 : begin
         for i:=1 to 5 do begin
           sound(254); delay(2000);
           nosound; delay(100);
         end;
       end;
   1 : begin
         for i:=1 to 5 do begin
           sound(254); delay(2000);
           nosound; delay(100);
         end;
       end;
  end;
end;

{ �㭪�� ����� �ᥫ � ����᪮� ०���
  x,y - ���न���� ��� ����� �᫠
  T1,T2 - ��ࠢ������� ⥪�� �⭮�⥫�� �窨 (x,y) }
Function Input(x,y : integer; T1,T2 : Word) : integer;
 Var  key : char;
      k,ret,c1,c2,c3,c4 : integer;
      text : string;
      textX,textY : integer;
 Begin
  if T1=CenterText then begin c1:=1; c2:=1; end;
  if T1=LeftText then begin c1:=0; c2:=2; end;
  if T1=RightText then begin c1:=2; c2:=0; end;
  if T2=CenterText then begin c3:=1; c4:=1; end;
  if T2=LeftText then begin c3:=0; c4:=2; end;
  if T2=RightText then begin c3:=2; c4:=0; end;

  key:=' ';
  ret:=0; textX:=0; textY:=0;
  SettextJustify(T1, T2);
  SetFillStyle(EmptyFill, Black);
  { ���� �� ������ �� ������� ����... }
  while (Ord(key)<>13) do begin
   { ���� ������ ������ }
   repeat until KeyPressed;
   { ����砥� ᨬ��� �� ���� ����������}
   key:=ReadKey;
   { ��।��塞 ��� ᨬ���� }
   k:=Ord(key);
   { �᫨ ������ �� ������� BackSpace, � 㡨ࠥ� � �᫠ ��᫥���� ���� }
   if k=8 then ret:=round(ret/10);
   { �᫨ ������ �� ����, � ������塞 �� � ����� �᫠ }
   if (k>=48) AND (k<=57) then ret:=ret*10+(k-48);
   { ����訢��� � ����, ��� ��᫥���� ࠧ �뢮���� �᫮ }
   bar (x-c1*round(textX/2),y-c3*round(textY/2),
        x+c2*round(textX/2),y+c4*round(textY/2));
   Str(ret,text);
   textX:=TextWidth(text);
   textY:=TextHeight(text);
   { �뢮��� �� ��࠭ ����� �᫮ }
   OutTextXY(x,y,text);
  end;
 Input:=ret;
 end;

{ �㭪��, ������� ����� ��ࢮ�� ⨯�:
  "�த����� �᫮��� ��" }
Function Test_tip1(MaxN : integer) : integer;
 Var i,result,x,y : integer;
     Text,text1 : string;
 Begin
  Text:='';
  for i:=1 to MaxN-1 do begin
    Str(N[i][1],text1);
    Text:=Text+text1+' ';
  end;
  Text:=Text+'? ';
  SettextJustify(CenterText, CenterText);
  SetTextStyle(DefaultFont, 0, 1);
  OutTextXY(round(MaxX/2),round(MaxY/2),'�த����� �᫮��� ��');
  OutTextXY(round(MaxX/2),round(MaxY/2)+100,Text);
  x:=TextWidth(Text);
  y:=TextHeight(Text);
  result:=Input(round(MaxX/2)+round(x/2),round(MaxY/2)+100,
          LeftText, CenterText);
  if result=N[MaxN][1] then Test_tip1:=1 else Test_tip1:=0;
 End;

{ �㭪��, ������� ����� ��ண� ⨯�:
  "��⠢�� �������饥 � ��㣥 �᫮" }
Function Test_tip2(MaxN : integer) : integer;
 Var i,ret : integer;
     text : string;
 Begin
  SettextJustify(CenterText, CenterText);
  SetTextStyle(DefaultFont, 0, 1);
  OutTextXY(round(MaxX/2),round(MaxY/2)-50,'��⠢�� �������饥 �᫮');
  Circle(round(MaxX/2), round(MaxY/2)+100, 100);
  for i:=1 to MaxN do begin
   Line(round(MaxX/2), round(MaxY/2)+100,
        round(MaxX/2+100*cos(2*Pi/MaxN*i-Pi/2)),
        round(MaxY/2+100+100*sin(2*Pi/MaxN*i-Pi/2)));
   if i<>MaxN then Str(N[i][1],text) else text:='';
   OutTextXY(round(MaxX/2+70*cos(2*Pi/MaxN*i-Pi/2-Pi/MaxN)),
             round(MaxY/2+100+70*sin(2*Pi/MaxN*i-Pi/2-Pi/MaxN)),text)
  end;
  ret:=Input(round(MaxX/2+70*cos(2*Pi-Pi/2-Pi/MaxN)),
             round(MaxY/2+100+70*sin(2*Pi-Pi/2-Pi/MaxN)),
             CenterText,CenterText);
  if ret=N[MaxN][1] then Test_tip2:=1 else Test_tip2:=0;
 End;

{ �㭪��, ������� ����� ���쥣� ⨯�:
  "��⠢�� �ய�饭��� �᫮" }
Function Test_tip3 : integer;
 Var text, text1 : string;
     ret : integer;
 Begin
  text:='';
  SettextJustify(CenterText, CenterText);
  SetTextStyle(DefaultFont, 0, 1);
  OutTextXY(round(MaxX/2),round(MaxY/2),'��⠢�� �ய�饭��� �᫮');
  Str(N[1][1],text1); text:=text+text1+' (';
  if N[2][1]<100 then text:=text+' ';
  Str(N[2][1],text1); text:=text+text1+') ';
  Str(N[3][1],text1); text:=text+text1;
  OutTextXY(round(MaxX/2),round(MaxY/2)+40,text);
  text:='';
  Str(N[1][2],text1); text:=text+text1+' (   ) ';
  Str(N[3][2],text1); text:=text+text1;
  OutTextXY(round(MaxX/2),round(MaxY/2)+60,text);
  ret:=Input(round(MaxX/2),round(MaxY/2)+60, CenterText, CenterText);
  if ret=N[2][2] then Test_tip3:=1 else Test_tip3:=0;
 End;

{ �㭪��, ������� ����� �⢥�⮣� ⨯�:
  "��⠢�� �ய�饭��� �᫠ (�����)" }
Function Test_tip4 : integer;
 Var i,j,ret,x,y : integer;
     text, text1 : string;
 Begin
  SettextJustify(CenterText, CenterText);
  SetTextStyle(DefaultFont, 0, 1);
  OutTextXY(round(MaxX/2),round(MaxY/2),'��⠢�� �ய�饭��� �᫮');
  for i:=1 to 2 do begin
   text:='';
   Str(N[1][i],text1); text:=text+text1+' ';
   Str(N[2][i],text1); text:=text+text1+' ';
   Str(N[3][i],text1); text:=text+text1+' ';
   OutTextXY(round(MaxX/2),round(MaxY/2)+40+20*i,text)
  end;
  x:=round(MaxX/2-TextWidth(Text)/2);
  text:='';
  Str(N[1][i],text1); text:=text+text1+' ';
  Str(N[2][i],text1); text:=text+text1+' ';
  SettextJustify(LeftText, CenterText);
  OutTextXY(x,round(MaxY/2)+40+20*3,text);
  ret:=Input(x+TextWidth(Text),round(MaxY/2)+40+20*3,
             LeftText, CenterText);
  if ret=N[3][3] then Test_tip4:=1 else Test_tip4:=0;
 End;

Begin
 ClrScr;
 OpenFile('Test.dat');
 { ���樠������ ����᪮�� ०��� }
 GraphDetect := Detect;
 InitGraph(GraphDetect, GraphMode, '');
 if GraphResult <> grOk then begin
   writeln('�訡�� ���樠����樨 ����᪮�� ०���');
   Halt(1);
 end;
 { ���������� ���ᨬ���� ࠧ���� ��࠭� }
 MaxX:=GetMaxX;
 MaxY:=GetMaxY;

 { �뢮� 蠯�� ��� }
 SettextJustify(CenterText, CenterText);
 SetTextStyle(SansSerifFont, 0, 10);
 OutTextXY(round(MaxX/2), 50, 'TECT');
 SetTextStyle(SansSerifFont, 0, 3);
 OutTextXY(round(MaxX/2), 130,'�஢���� ᢮� ᯮᮡ����');
 Rectangle(100,20,MaxX-100, 150);
 SetFillStyle(EmptyFill, Black);

 Result:=0;
 MaxTest:=ReadFromFile; { ���뢠�� �� 䠩�� ��饥 �᫮ ����ᮢ }
 for i:=1 to MaxTest do begin
  TestTip:=ReadFromFile; { ���뢠�� �� 䠩�� ⨯ ����� }
  { ��� ������� ����� ���뢠�� �� 䠩�� �᫠ � ���ᨢ N
    � ��뢠�� �㭪��, ᮮ⢥�������� ⨯� ����� }
  Case TestTip of
   1 : begin
         MaxN:=ReadFromFile;
         for j:=1 to MaxN do N[j][1]:=ReadFromFile;
         Result:=Result+Test_tip1(MaxN);
       end;
   2 : begin
         MaxN:=ReadFromFile;
         for j:=1 to MaxN do N[j][1]:=ReadFromFile;
         Result:=Result+Test_tip2(MaxN);
       end;
   3 : begin
         MaxN:=ReadFromFile;
         for j:=1 to 3 do N[j][1]:=ReadFromFile;
         for j:=1 to 3 do N[j][2]:=ReadFromFile;
         Result:=Result+Test_tip3;
       end;
   4 : begin
         MaxN:=ReadFromFile;
         for j:=1 to 3 do N[j][1]:=ReadFromFile;
         for j:=1 to 3 do N[j][2]:=ReadFromFile;
         for j:=1 to 3 do N[j][3]:=ReadFromFile;
         Result:=Result+Test_tip4;
       end;
  end;
  bar(0,160,MaxX,MaxY);
 end;

 { �뢮�� १���� ��� }
 Result:=round(150/MaxTest*Result);
 SettextJustify(CenterText, CenterText);
 OutTextXY(round(MaxX/2), round(MaxY/2),
           '����ࠢ���! ��� �����樥�� ��⥫���㠫쭮�� ࠢ��');
 SetTextStyle(SansSerifFont, 0, 10);
 Str(Result, text);
 OutTextXY(round(MaxX/2), round(MaxY/2)+100,text);

 { ����뢠�� 䠩� }
 Close(F);
 { ���� ������ �� ������ }
 repeat until KeyPressed;
 ClearDevice;
 { �����⨥ ����᪮�� ०��� }
 CloseGraph;
end.
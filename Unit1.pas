unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ADODB, ComCtrls, ImgList,
  ToolWin, DB, frxDesgn, frxClass,xpman, frxExportRTF, frxExportXLS,
  frxDBSet;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Memo1: TMemo;
    ADOConnection1: TADOConnection;
    Zapros: TADOQuery;
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ImageList1: TImageList;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    Zapros2: TADOQuery;
    DBGrid1: TDBGrid;
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    frxXLSExport1: TfrxXLSExport;
    frxRTFExport1: TfrxRTFExport;
    frxDBDataset1: TfrxDBDataset;
    frxDBDataset2: TfrxDBDataset;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; mydate:string;

implementation

uses Unit2, Unit3;

{$R *.dfm}

Function ChangeT(s:string):string;
var i:integer; c:char; ss:string;
begin
   ss:='';
   for i:=1 to length(s) do
   begin
      c:=s[i];
      if c<>'.' then ss:=ss+c else ss:=ss+',';
   end;
   ChangeT:=ss;
end;

function DosToWin(St: string): string;
var Ch: PChar;
begin
   Ch := StrAlloc(Length(St) + 1);
   OemToAnsi(PChar(St), Ch);
   Result := Ch;
   StrDispose(Ch)
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
var i:integer; s,ss:string;
begin
   s := GetCurrentDir;
   if OpenDialog1.Execute then
   begin
      mydate:=copy(OpenDialog1.FileName,Length(OpenDialog1.FileName)-7,8);
      mydate:=copy(mydate,1,2)+'.'+copy(mydate,3,2)+'.'+copy(mydate,5,4);
      Zapros.SQL.Clear;
      zapros.SQL.Add('SELECT * FROM operations;');
      Zapros.Open;
      Zapros2.SQL.Clear;
      zapros2.SQL.Add('SELECT terminal,name FROM agents order by terminal;');
      Zapros2.Open;
      memo1.Clear;
      memo1.Lines.LoadFromFile(OpenDialog1.FileName);
      for i:=0 to memo1.Lines.Count-1 do
      begin
         if (copy(memo1.Lines.Strings[i],2,4)='4647')and(length(memo1.Lines.Strings[i])>=100) then
         begin
            Zapros.Append;
            if copy(memo1.Lines.Strings[i],73,3)='USD' then Zapros['val']:='Долар США';
            if copy(memo1.Lines.Strings[i],73,3)='EUR' then Zapros['val']:='Евро';
            if copy(memo1.Lines.Strings[i],73,3)='RUB' then Zapros['val']:='Рос. рубль';
            if copy(memo1.Lines.Strings[i],73,3)='UAH' then Zapros['val']:='Укр. гривна';
            Zapros['summa']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],59,14)));
            Zapros['komis']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],76,11)));
            if (Zapros['komis']<>0) then
            begin
               try
                  Zapros['komis2']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],91,11)));
                  Zapros['komis3']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],102,11)));
                  Zapros['type']:=2;
               Except
                  Zapros['komis3']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],76,11)));
                  Zapros['komis2']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],87,11)));
                  Zapros['type']:=1;
               End;
            end else begin
                        Zapros['komis2']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],87,11)));
                        Zapros['komis3']:=strtofloat(changeT(copy(memo1.Lines.Strings[i],98,11)));
                        Zapros['type']:=1;
                     end;
            Zapros['Agentkod']:=copy(memo1.Lines.Strings[i],2,8);
            if Zapros2.Locate('terminal',copy(memo1.Lines.Strings[i],2,8),[])=true then
               Zapros['Agent']:=vartostr(Zapros2['name'])
            else begin
                    ss:='';
                    while (ss='') do
                    begin
                       ss:=InputBox('Новый терминал: '+copy(memo1.Lines.Strings[i],2,8), 'Введите, пожалуйста, его название:', '');
                       if ss<>'' then
                       begin
                          Zapros2.Close;
                          Zapros2.SQL.Clear;
                          Zapros2.SQL.Add('INSERT INTO agents([terminal],[name]) VALUES (:Param1,:Param2);');
                          Zapros2.Parameters.ParamByName('Param1').Value:=copy(memo1.Lines.Strings[i],2,8);
                          Zapros2.Parameters.ParamByName('Param2').Value:=ss;
                          Zapros2.ExecSQL;
                          Zapros2.SQL.Clear;
                          zapros2.SQL.Add('SELECT terminal,name FROM agents order by terminal;');
                          Zapros2.Open;
                          Zapros['Agent']:=ss;
                       end;
                    end;
                 end;
            Zapros['Numoper']:=1;
            Zapros.post;
         end;
      end;
      Zapros.close;
      zapros.SQL.Clear;
      zapros.SQL.Add('SELECT * FROM operations order by agentkod,val;');
      zapros.Open;
      StatusBar1.SimpleText:='Всего  '+inttostr(zapros.RecordCount)+' операций';
   end else ShowMessage('Вы не указали файл!');
   SetCurrentDir(s);
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
   if (MessageDlg('Выйти из программы ?', mtInformation, [mbYes, mbNo], 0) = mrYes) then
   begin
      Zapros.SQL.Clear;
      zapros.SQL.Add('DELETE FROM operations;');
      zapros.ExecSQL;
      Application.Terminate;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Zapros.SQL.Clear;
   zapros.SQL.Add('DELETE FROM operations;');
   zapros.ExecSQL;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
var s,ss:string;
begin
   ss:=InputBox('Формирование отчёта: ', '1. Детальный отчёт; 2. Сводный отчёт.', '');
   if ss='1' then
   begin
      Zapros.close;
      zapros.SQL.Clear;
      zapros.SQL.Add('SELECT * FROM operations WHERE type=1 order by agentkod,val;');
      zapros.Open;
      Zapros2.close;
      zapros2.SQL.Clear;
      zapros2.SQL.Add('SELECT * FROM operations WHERE type=2 order by agentkod,val;');
      zapros2.Open;
      if (not(Zapros.IsEmpty))or(not(Zapros2.IsEmpty)) then
      begin
         frxDBDataset1.DataSet:=Zapros;
         frxDBDataset2.DataSet:=Zapros2;
         form1.frxReport1.Script.Variables['Opername']:='Операции';
         try
            form1.frxReport1.Script.Variables['dt']:=strtodate(mydate);
         except
            form1.frxReport1.Script.Variables['dt']:=date;
         end;
         form1.frxReport1.LoadFromFile('data\shabl.fr3');
         s := GetCurrentDir;
         form1.frxReport1.ShowReport;
         SetCurrentDir(s);
      end;
   end;
   if ss='2' then
   begin
      Zapros.close;
      zapros.SQL.Clear;
      zapros.SQL.Add('SELECT agent,val,sum(summa) as s1, sum(komis3) as d1, sum(numoper) as k1 FROM operations WHERE type=1 Group by agent,val;');
      zapros.Open;
      Zapros2.close;
      zapros2.SQL.Clear;
      zapros2.SQL.Add('SELECT agent,val,sum(summa) as s2,sum(komis+komis2+komis3) as t2, sum(komis2) as d2, sum(numoper) as k2 FROM operations WHERE type=2 Group by agent,val;');
      zapros2.Open;
      if (not(Zapros.IsEmpty))or(not(Zapros2.IsEmpty)) then
      begin
         frxDBDataset1.DataSet:=Zapros;
         frxDBDataset2.DataSet:=Zapros2;
         form1.frxReport1.Script.Variables['Opername']:='Операции';
         try
            form1.frxReport1.Script.Variables['dt']:=strtodate(mydate);
         except
            form1.frxReport1.Script.Variables['dt']:=date;
         end;
         form1.frxReport1.LoadFromFile('data\shabl2.fr3');
         s := GetCurrentDir;
         form1.frxReport1.ShowReport;
         SetCurrentDir(s);
      end;
   end;
   Zapros.Close;
   Zapros.SQL.Clear;
   zapros.SQL.Add('SELECT * FROM operations;');
   Zapros.Open;
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
   Application.CreateForm(TAgentForm, AgentForm);
   AgentForm.ShowModal;
end;

end.

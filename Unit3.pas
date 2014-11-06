unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ExtCtrls, DBCtrls,adodb;

type
  TAgentForm = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AgentForm: TAgentForm;

implementation

uses Unit1;

{$R *.dfm}

procedure TAgentForm.FormShow(Sender: TObject);
var MySource:TDataSource; Zapros:TADOQuery;
begin
   Zapros:=TADOQuery.Create(nil);
   Zapros.Connection:=Form1.ADOConnection1;
   with Zapros do
   begin
      SQL.Clear;
      SQL.Add('SELECT terminal,name');
      SQL.Add('FROM agents order by terminal;');
   end;
   Zapros.Open;
   MySource:=TDataSource.Create(nil);
   MySource.DataSet:=Zapros;
   DBGrid1.DataSource:=MySource;
   DBNavigator1.DataSource:=MySource;
end;

procedure TAgentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

end.

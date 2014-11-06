unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox3: TComboBox;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1, Math;

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
   close;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
   combobox1.Text:='';combobox3.Text:='';
   RadioButton1.Checked:=false; RadioButton2.Checked:=false;
   combobox1.Clear;
   form1.Zapros2.close;
   form1.Zapros2.SQL.Clear;
   form1.zapros2.SQL.Add('SELECT DISTINCT(agentkod) FROM operations;');
   form1.Zapros2.Open;
   while not(form1.Zapros2.Eof) do
   begin
       combobox1.Items.Add(form1.Zapros2['agentkod']);
      form1.Zapros2.Next;
   end;
   form1.Zapros2.close;
end;

procedure TForm2.Button1Click(Sender: TObject);
var s:string;
begin
   form1.frxReport1.LoadFromFile('data\shabl.fr3');
   s := GetCurrentDir;
   form1.frxReport1.ShowReport;
   SetCurrentDir(s);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   form1.Zapros.close;
   form1.zapros.SQL.Clear;
   form1.zapros.SQL.Add('SELECT * FROM operations order by agentkod,val;');
   form1.zapros.Open;
end;

procedure TForm2.ComboBox3Change(Sender: TObject);
begin
   combobox1.Text:='';
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
   combobox3.Text:='';
end;

end.

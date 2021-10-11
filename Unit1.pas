unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ExtDlgs, OleCtrls, SHDocVw,
  ComCtrls, ExtActns, Tabs, StrUtils, ShellApi;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SaveDialog1: TSaveDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    GroupBox3: TGroupBox;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ProgressBar1: TProgressBar;
    TabControl1: TTabControl;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    CheckBox2: TCheckBox;
    Edit2: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    WebBrowser1: TWebBrowser;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure WebBrowser1ProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses about, Unit2;

{$R *.dfm}

//---------------------------------------------------------------
//Fonction de convertion d'un TColor en Hexadécimal (Couleur HTML)
//---------------------------------------------------------------
function cHTML(Col:TColor):String;
var St:String;
begin
  St:=IntToHex(Col,6);
  Result:='#'+Copy(St,5,2)+Copy(St,3,2)+Copy(St,1,2);
end;
//---------------------------------------------------------------

//---------------------------------------------------------------
//La procédure du chargement de l'image
//---------------------------------------------------------------
procedure TForm1.SpeedButton1Click(Sender: TObject);
var
ImageTaille : boolean;
dLargeur : integer;
dHauteur : integer;
begin
//OpenPictureDialog1.FileName := '';
OpenPictureDialog1.Execute;
ImageTaille := False;
if (OpenPictureDialog1.FileName <> '') then begin
if (FileExists(OpenPictureDialog1.FileName)) then begin
  SpeedButton2.Enabled := true;
  Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  Image1.Show;
  dLargeur := (GroupBox1.Width-Image1.Width) div 2;
  dHauteur := (GroupBox1.Height-Image1.Height) div 2;
  Image1.Left := dLargeur;
  Image1.Top := dHauteur;
  OpenPictureDialog1.FileName := '';
end;
end;
if (Image1.Height > 100) then ImageTaille := True;
if (Image1.Width > 100) then ImageTaille := True;
 if (ImageTaille = true) then begin
  Image1.Hide;
  Image1.Height := 99;
  Image1.Width := 99;
  SpeedButton2.Enabled := False;
  Showmessage('L''image à importer ne peu être qu''au format *.BMP, et ces dimensions ne doivent pas dépasser 100x100.');
 end;
end;
//---------------------------------------------------------------

//---------------------------------------------------------------
//Precedure de visualisation de la Form 'A propos'
//---------------------------------------------------------------
procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
Form10.ShowModal;
end;
//---------------------------------------------------------------

//---------------------------------------------------------------
//Procedure de convertion de l'image
//---------------------------------------------------------------
procedure TForm1.SpeedButton2Click(Sender: TObject);
var
ImgX     : integer;
ImgY     : integer;
str      : string;
EndBalises : String;
List     : TStringList;
PixColor : String;
begin
  SaveDialog1.Execute;
  if (SaveDialog1.FileName <> '') then begin
    ImgX := 0;
    ImgY := 0;
    List := TStringList.Create;
      if (ComboBox1.ItemIndex = 0) then List.Add('<div align="left">');
      if (ComboBox1.ItemIndex = 1) then List.Add('<div align="center">');
      if (ComboBox1.ItemIndex = 2) then List.Add('<div align="right">');
    List.Add('<html><head><title>'+Edit1.Text+'</title>');
      if (CheckBox2.Checked = true) then List.Add('<script language="JavaScript"> alert('''+AnsiReplaceStr(Edit2.Text, '''', '`')+'''); </script>');

    List.Add('</head><body>');
    List.Add('<dl>');
      While (ImgY <= Image1.Height) do begin
          if (ImgX = 0) then List.Add('<dt>');
        While (ImgX <= Image1.Width) do begin
          PixColor := cHTML(Image1.Canvas.Pixels[ImgX, ImgY]);
          str  := str + '<font face="Times New Roman"><span style="font-size:1px; background-color:'+PixColor+';"><font color="'+PixColor+'">M</font>';
          EndBalises := EndBalises + '</span></font>';
            if (ImgX = Image1.Width) then inc(ImgY);
          inc(ImgX);
        end;
      //str := str + EndBalises;
      List.Add(str);
      List.Add(EndBalises+'</dt>');
      str := '';
      EndBalises := '';
      ImgX := 0;
  end;
  List.Add('</dl></body></html>');
  List.SaveToFile(SaveDialog1.FileName+'.html');
  List.Free;
    if (CheckBox1.Checked) then begin
    //Form3.Show;
    //Form3.WebBrowser1.Navigate(SaveDialog1.FileName+'.html');
    WebBrowser1.Navigate(SaveDialog1.FileName+'.html');
    end;
end;
//---------------------------------------------------------------

{
Commentaire final :_____________________________________________
J'éspère la source de ce petit programmme vous sera utile et que
vous avez bien compris sont fonctionnement. Si vous voulez avoir
plus d'informations n'hésitez pas à m'envoyer un email.
Site   :  http://iceblue.jexiste.fr/
eMail  :  hspeed666@hotmail.com
________________________________________________________________
}
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
WebBrowser1.Navigate('about:blank');

end;

procedure TForm1.WebBrowser1ProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
if webbrowser1.READYSTATE=1 then ProgressBar1.Position := 25;
if webbrowser1.READYSTATE=2 then ProgressBar1.Position := 50;
if webbrowser1.READYSTATE=3 then ProgressBar1.Position := 75;
if webbrowser1.READYSTATE=4 then ProgressBar1.Position := 100;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
if (CheckBox2.Checked = true) then Edit2.Enabled := true;
if (CheckBox2.Checked = false) then Edit2.Enabled := false;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
 Form1.WebBrowser1.Navigate('about:blank');
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
Form2.Show;
end;

end.

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    RichEdit1: TRichEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Aide : TResourceStream ;
implementation

{$R *.dfm}
{$R aide.res}

procedure TForm2.FormCreate(Sender: TObject);
begin
Aide := TResourceStream.Create(0,'AIDE','TEXT');
RichEdit1.Lines.LoadFromStream(Aide);
Aide.Free;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
Form2.Close;
end;

end.

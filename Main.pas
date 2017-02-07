unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  FRM.Drag,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Platform, FMX.StdCtrls, FMX.Layouts;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    DragFrame: TDragFrame;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormCreate(Sender: TObject);
begin
     DragFrame := TDragFrame.Create(Self);
     AddOBject(DragFrame);
end;

end.

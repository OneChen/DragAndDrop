program DragAndDrop;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {MainForm},
  FRM.Drag in 'FRM.Drag.pas' {DragFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

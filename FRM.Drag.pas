unit FRM.Drag;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Platform, FMX.StdCtrls, FMX.Layouts;

type
  TDragFrame = class(TFrame)
    Label1: TLabel;
    Splitter1: TSplitter;
    VertScrollBox1: TVertScrollBox;
    Rectangle2: TRectangle;
    Text1: TText;
    Rectangle3: TRectangle;
    Text2: TText;
    Rectangle4: TRectangle;
    Text3: TText;
    VertScrollBox2: TVertScrollBox;
    Rectangle5: TRectangle;
    Text4: TText;
    Rectangle6: TRectangle;
    Text5: TText;
    Rectangle7: TRectangle;
    Text6: TText;
    procedure Rectangle2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rectangle2DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure Rectangle2DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
  private
    LastOver: TControl;
    DesY: Single;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TDragFrame.Rectangle2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var Svc: IFMXDragDropService;
    DragData: TDragObject;
    DragImage: TBitmap;
begin
     if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, Svc) then
     begin
          DragImage       := TControl(Sender).MakeScreenshot;
          DragData.Source := Sender;
          DragData.Data   := DragImage;
          try
             Svc.BeginDragDrop(Application.MainForm, DragData, DragImage);
          finally
             DragImage.Free;
          end;
     end;
end;

procedure TDragFrame.Rectangle2DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
     Operation := TDragOperation.Copy;

     if Data.Source <> nil then
        Label1.Text := Format(' DragAndDrop by Aone , Src: %s, Des: %s, %f, %f', [TControl(Data.Source).Name, TControl(Sender).Name, Point.X, Point.Y]);

     if Sender is TVertScrollBox then
     begin
          DesY := Point.Y - 20;
          Exit;
     end;

     if LastOver <> nil then
     begin
          LastOver.Margins.Top := 5;
          LastOver.Margins.Bottom := 0;
     end;

     if Point.Y < 20 then
          TControl(Sender).Margins.Top := 20
     else TControl(Sender).Margins.Top := 5;

     if Point.Y > TControl(Sender).Height - 20 then
          TControl(Sender).Margins.Bottom := 20
     else TControl(Sender).Margins.Bottom := 0;

     if Point.Y < TControl(Sender).Height / 2 then
          DesY := TControl(Sender).Position.Y - TControl(Sender).Margins.Top - 1
     else DesY := TControl(Sender).Position.Y + TControl(Sender).Margins.Bottom + TControl(Sender).Height + 1;

     LastOver := TControl(Sender);
end;

procedure TDragFrame.Rectangle2DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
     Label1.Text := Format(' DragAndDrop by Aone -> Src: %s, Des: %s, %f, %f', [TControl(Data.Source).Name, TControl(Sender).Name, Point.X, Point.Y]);

     if LastOver <> nil then
     begin
          LastOver.Margins.Top := 5;
          LastOver.Margins.Bottom := 0;
     end;

     if Sender is TVertScrollBox then
          TControl(Sender).AddObject(TControl(Data.Source))
     else TControl(Sender).Parent.AddObject(TControl(Data.Source));
     TControl(Data.Source).Position.Y := DesY;
end;

end.

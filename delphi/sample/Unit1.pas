(*******************************************************************************
 *
 * Copyright (C) 2026 Atmarkartworks
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*******************************************************************************)
unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Math,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Math.Vectors, FMX.Ani,
  FMX.Objects, FMX.Layers3D, FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D;

type
  TForm1 = class(TForm)

    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RR3Click(Sender: TObject);
    procedure RoundRect1Click(Sender: TObject);
  private
    { Private declarations }
    Timer1: TTimer;
    Viewport3D1: TViewport3D;
    Grid3D1: TGrid3D;
    Layer3D1: TLayer3D;
    Line1: TLine;
    Layer3D2: TLayer3D;
    Line2: TLine;
    RoundRect1: TRoundRect;
    Label2: TLabel;
    Line4: TLine;
    Line5: TLine;
    Layer3D3: TLayer3D;
    Line3: TLine;
    RR3: TRoundRect;
    Label1: TLabel;
    FloatAnimation1: TFloatAnimation;
    RR3Line: TLine;
    RR3Line2: TLine;

    FAngle, FAngle3: Single;
    FIsFilamentOpen: Boolean;
    procedure MoveRR3;
    procedure OpenFilament;
    procedure CloseFilament;
    procedure SetIsFilamentOpen(const Value: Boolean);
  public
    { Public declarations }
    property IsFilamentOpen: Boolean read FIsFilamentOpen write SetIsFilamentOpen;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{$IFDEF Android}

uses
  AAW.JNI.mylibrary,
  Androidapi.Helpers,
  Androidapi.JNI.App,

  Androidapi.JNI.GraphicsContentViewText,
  FMX.Helpers.Android

  ,Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  FMX.Platform.Android;
const
  MAIN_COLOR: TAlphaColor = TAlphaColors.Gray;
var
  MyActivity: JActivity;
{$ENDIF}



//
// @2026-April-2
//


procedure TForm1.FormCreate(Sender: TObject);
begin
  // --- Viewport3D1 ---
  Viewport3D1 := TViewport3D.Create(Self);
  Viewport3D1.Parent := Self;
  Viewport3D1.Align  := TAlignLayout.Client;

  // --- Grid3D1 ---
  Grid3D1 := TGrid3D.Create(Self);
  Grid3D1.Parent           := Viewport3D1;
  Grid3D1.Marks            := 4;
  Grid3D1.Frequency        := 1;
  Grid3D1.LineColor        := $50505050;
  Grid3D1.RotationAngle.X  := -90;
  Grid3D1.Width            := 20;
  Grid3D1.Height           := 20;
  Grid3D1.Depth            := 0.001;

  // --- Layer3D1 (child: Line1) ---
  Layer3D1 := TLayer3D.Create(Self);
  Layer3D1.Parent          := Grid3D1;
  Layer3D1.Fill.Color      := TAlphaColors.Null;
  Layer3D1.Fill.Kind       := TBrushKind.Solid;
  Layer3D1.Width           := 5;
  Layer3D1.Height          := 12;
  Layer3D1.Position.Y      := 4;
  Layer3D1.Position.Z      := -6;
  Layer3D1.Resolution      := 50;
  Layer3D1.RotationAngle.X := 90;
  Layer3D1.StyleLookup     := 'backgroundstyle';

  Line1 := TLine.Create(Self);
  Line1.Parent             := Layer3D1;
  Line1.LineType           := TLineType.Diagonal;
  Line1.Position.X         := 125;
  Line1.Size.PlatformDefault := False;
  Line1.Width              := 1;
  Line1.Height             := 600;
  Line1.Stroke.Color       := MAIN_COLOR;
  Line1.Stroke.Kind        := TBrushKind.Solid;
  Line1.Stroke.Thickness   := 2.0;

  // --- Layer3D2 (children: Line2, RoundRect1, Line4, Line5) ---
  Layer3D2 := TLayer3D.Create(Self);
  Layer3D2.Parent          := Grid3D1;
  Layer3D2.Fill.Color      := TAlphaColors.Null;
  Layer3D2.Fill.Kind       := TBrushKind.Solid;
  Layer3D2.Width           := 9;
  Layer3D2.Height          := 12;
  Layer3D2.Position.X      := 4;
  Layer3D2.Position.Z      := -6;
  Layer3D2.Resolution      := 50;
  Layer3D2.RotationAngle.X := 90;
  Layer3D2.RotationAngle.Y := 90;
  Layer3D2.StyleLookup     := 'backgroundstyle';

  Line2 := TLine.Create(Self);
  Line2.Parent             := Layer3D2;
  Line2.LineType           := TLineType.Diagonal;
  Line2.Position.X         := 225;
  Line2.Position.Y         := 350;
  Line2.Size.PlatformDefault := False;
  Line2.Width              := 1;
  Line2.Height             := 350;
  Line2.Stroke.Color       := MAIN_COLOR;
  Line2.Stroke.Kind        := TBrushKind.Solid;
  Line2.Stroke.Thickness   := 2.0;


  RoundRect1 := TRoundRect.Create(Self);
  RoundRect1.Parent        := Layer3D2;
  RoundRect1.Fill.Color    := TAlphaColors.Null;
  RoundRect1.Position.X    := 287;
  RoundRect1.Position.Y    := 367;
  RoundRect1.Size.PlatformDefault := False;
  RoundRect1.Width         := 145;
  RoundRect1.Height        := 33;
  RoundRect1.OnClick       := RoundRect1Click;
  RoundRect1.Stroke.Color  := MAIN_COLOR;
  RoundRect1.Stroke.Kind   := TBrushKind.Solid;
  RoundRect1.Stroke.Thickness := 1.0;

  Label2 := TLabel.Create(Self);
  Label2.Parent                   := RoundRect1;
  Label2.Align                    := TAlignLayout.Client;  // Fill entire RoundRect1 so HorzAlign=Center works
  Label2.TextSettings.Font.Family := 'Roboto';
  Label2.TextSettings.HorzAlign   := TTextAlign.Center;
  Label2.TextSettings.VertAlign   := TTextAlign.Center;
  Label2.Text                     := 'O P E N';
  Label2.StyledSettings         := Label2.StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
  Label2.TextSettings.Font.Style := [TFontStyle.fsBold];
  Label2.TextSettings.FontColor := MAIN_COLOR;

  Line4 := TLine.Create(Self);
  Line4.Parent             := Layer3D2;
  Line4.LineType           := TLineType.Diagonal;
  Line4.Position.X         := 257;
  Line4.Position.Y         := 385;
  Line4.Size.PlatformDefault := False;
  Line4.Width              := 30;
  Line4.Height             := 1;
  Line4.Opacity            := 0.3;
  Line4.Stroke.Color       := MAIN_COLOR;
  Line4.Stroke.Kind        := TBrushKind.Solid;
  Line4.Stroke.Thickness   := 1.0;

  Line5 := TLine.Create(Self);
  Line5.Parent             := Layer3D2;
  Line5.LineType           := TLineType.Diagonal;
  Line5.Position.X         := 216;
  Line5.Position.Y         := 385;
  Line5.RotationAngle      := -43;
  Line5.RotationCenter.X   := 1;
  Line5.RotationCenter.Y   := 1;
  Line5.Size.PlatformDefault := False;
  Line5.Width              := 42;
  Line5.Height             := 1;
  Line5.Opacity            := 0.3;
  Line5.Stroke.Color       := MAIN_COLOR;
  Line5.Stroke.Kind        := TBrushKind.Solid;
  Line5.Stroke.Thickness   := 1.0;

  // --- Layer3D3 (children: Line3, RR3, RR3Line, RR3Line2) ---
  Layer3D3 := TLayer3D.Create(Self);
  Layer3D3.Parent          := Grid3D1;
  Layer3D3.Fill.Color      := TAlphaColors.Null;
  Layer3D3.Fill.Kind       := TBrushKind.Solid;
  Layer3D3.Width           := 12;
  Layer3D3.Height          := 12;
  Layer3D3.Position.Y      := -4;
  Layer3D3.Position.Z      := -6;
  Layer3D3.Resolution      := 50;
  Layer3D3.RotationAngle.X := 90;
  Layer3D3.RotationAngle.Y := 180;
  Layer3D3.StyleLookup     := 'backgroundstyle';

  Line3 := TLine.Create(Self);
  Line3.Parent             := Layer3D3;
  Line3.LineType           := TLineType.Diagonal;
  Line3.Position.X         := 300;
  Line3.Size.PlatformDefault := False;
  Line3.Width              := 1;
  Line3.Height             := 1200;
  Line3.Stroke.Color       := MAIN_COLOR;
  Line3.Stroke.Kind        := TBrushKind.Solid;
  Line3.Stroke.Thickness   := 2.0;

  RR3 := TRoundRect.Create(Self);
  RR3.Parent               := Layer3D3;
  RR3.Fill.Color           := TAlphaColors.Null;
  RR3.Position.X           := 430;
  RR3.Position.Y           := 300;
  RR3.Size.PlatformDefault := False;
  RR3.Width                := 145;
  RR3.Height               := 33;
  RR3.OnClick              := RR3Click;
   RR3.Stroke.Color        := MAIN_COLOR;
  RR3.Stroke.Kind          := TBrushKind.Solid;
  RR3.Stroke.Thickness     := 1.0;

  Label1 := TLabel.Create(Self);
  Label1.Parent                   := RR3;
  Label1.Align                    := TAlignLayout.Client;  // Fill entire RR3 so HorzAlign=Center works
  Label1.TextSettings.Font.Family := 'Roboto';
  Label1.TextSettings.HorzAlign   := TTextAlign.Center;
  Label1.TextSettings.VertAlign   := TTextAlign.Center;
  Label1.Text                     := 'F i l a m e n t';

  FloatAnimation1 := TFloatAnimation.Create(Self);
  FloatAnimation1.Parent        := Label1;   // equivalent to Label1.AddObject
  FloatAnimation1.Duration      := 0.2;
  FloatAnimation1.PropertyName  := 'Opacity';
  FloatAnimation1.StartValue    := 0;
  FloatAnimation1.StopValue     := 0;

  RR3Line := TLine.Create(Self);
  RR3Line.Parent           := Layer3D3;
  RR3Line.LineType         := TLineType.Diagonal;
  RR3Line.Position.X       := 400;
  RR3Line.Position.Y       := 316;
  RR3Line.Size.PlatformDefault := False;
  RR3Line.Width            := 30;
  RR3Line.Height           := 1;
  RR3Line.Opacity          := 0.3;
  RR3Line.Stroke.Color     := MAIN_COLOR;
  RR3Line.Stroke.Kind      := TBrushKind.Solid;
  RR3Line.Stroke.Thickness := 1.0;

  RR3Line2 := TLine.Create(Self);
  RR3Line2.Parent          := Layer3D3;
  RR3Line2.LineType        := TLineType.Diagonal;
  RR3Line2.Position.X      := 300;
  RR3Line2.Position.Y      := 400;
  RR3Line2.RotationCenter.X := 0;
  RR3Line2.RotationCenter.Y := 0;
  RR3Line2.Size.PlatformDefault := False;
  RR3Line2.Width           := 100;
  RR3Line2.Height          := 1;
  RR3Line2.Opacity         := 0.3;
  RR3Line2.Stroke.Color    := MAIN_COLOR;
  RR3Line2.Stroke.Kind     := TBrushKind.Solid;
  RR3Line2.Stroke.Thickness := 1.0;

  // --- Timer1 ---
  Timer1 := TTimer.Create(Self);
  Timer1.Interval := 33;
  Timer1.OnTimer  := Timer1Timer;
  // --- Initial position ---
  Line1.Position.Y := 450;
end;




procedure TForm1.MoveRR3;
const
  rad: Single = 1 / 360;
begin
  FAngle3 := FAngle3 - rad*10;
  var rad2 := (-1 - cos(FAngle3)) / 2;
  RR3Line2.RotationAngle := 0.7 * RadToDeg(1.5*rad2) - RadToDeg(0.3);
  //Line1.width := 100.0 / cos(1.5*rad2);
  RR3Line2.width := 100.0 / cos(DegToRad(RR3Line2.RotationAngle));

  var Ly := RR3Line2.Position.Y + RR3Line2.Width * sin(DegToRad(RR3Line2.RotationAngle));
  RR3.Position.Y := Ly - RR3.Height / 2;

  RR3Line.Position.Y := Ly;

end;


procedure TForm1.OpenFilament;
begin
{$IFDEF Android}
  TJMyLibMainActivityUtil.JavaClass.create(MainActivity);
{$ENDIF}
  IsFilamentOpen := True;
  label2.Text := 'C L O S E';
  Label2.TextSettings.FontColor := TAlphaColors.Darkmagenta;
end;

procedure TForm1.CloseFilament;
begin
{$IFDEF Android}
  TJMyLibMainActivityUtil.JavaClass.destroy(MainActivity);
{$ENDIF}
  IsFilamentOpen := False;

  Label2.TextSettings.FontColor := MAIN_COLOR;
  Label2.Text := 'O P E N';
end;

procedure TForm1.RoundRect1Click(Sender: TObject);
begin
  if IsFilamentOpen then begin
    CloseFilament;

  end else begin
    OpenFilament;
  end;
end;

procedure TForm1.RR3Click(Sender: TObject);
begin
  if IsFilamentOpen then
    CloseFilament
  else
    OpenFilament;
end;

procedure TForm1.SetIsFilamentOpen(const Value: Boolean);
begin
  FIsFilamentOpen := Value;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  rad: Single = 1 / 360;
begin


  if FAngle < -360 then FAngle := 0;
  FAngle := FAngle - 0.5;
  Grid3d1.RotationAngle.Z := FAngle;



  Label1.Opacity := abs(sin(DegToRad(FAngle*9)));
  Label2.Opacity := abs(cos(DegToRad(FAngle*9)));

  MoveRR3;
end;

end.




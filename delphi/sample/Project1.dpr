program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,

  Unit1 in 'Unit1.pas' {Form1}
  {$IFDEF Android}
  ,
  AAW.JNI.mylibrary in '..\bridge\mylibrary\AAW.JNI.mylibrary.pas';
  {$ELSE}
  ;
  {$ENDIF}
  
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

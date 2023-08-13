unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ScktComp;

type
  TKomut = (kmYardim, kmListe, kmGoster, kmCD, kmDurum, kmCik);
  TDTTelnetServer = class(TService)
    ServerSocket: TServerSocket;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceExecute(Sender: TService);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    function KomutIsle(Cmd: string; out Komut: TKomut; out Parametre: string): Boolean;
    procedure KomutCalistir(Komut: TKomut; const Parametre: string; Soket: TCustomWinSocket);
  public
    {
     Delphi 4 ve altý için:
     function GetServiceController: PServiceController; override;
    }
    function GetServiceController: TServiceController; override;



    { Public declarations }
  end;

const
 Komutlar: array[TKomut] of string = ('YARDIM', 'LISTE', 'GOSTER', 'CD', 'DURUM', 'CIK');
 KomutYardimlar: array[TKomut] of string = ('YARDIM: Yardým bilgisini gösterir',
                                            'LISTE : Aktif dizin içeriðini gösterir',
                                            'GOSTER: Belirtilen dosyanýn içeriðini gösterir',
                                            'CD    : Aktif dizini deðiþtirir',
                                            'DURUM : Sunucu durum bilgisini gösterir',
                                            'CIK   : Ýstemci baðlantýsýný keser');



var
  DTTelnetServer: TDTTelnetServer;

implementation

{$R *.DFM}
uses FileCtrl;
type
  TIstemciBilgi = class
   private
    FZaman: TDateTime;
    FAktifDizin : string;
    FSonKomut: string;
   public
    constructor Create(BaglantiZamani: TDateTime);
    property Zaman: TDateTime read FZaman write FZaman;
    property AktifDizin: string read FAktifDizin write FAktifDizin;
    property SonKomut: string read FSonKomut write FSonKomut;
  end;


procedure FindFiles(StartDir, FileMask: string; List: TStringList);
var
  SR: TSearchRec;
  IsFound: Boolean;
begin
  if StartDir[length(StartDir)] <> '\' then
    StartDir := StartDir + '\';
  IsFound :=
    FindFirst(StartDir+FileMask, faAnyFile+faDirectory, SR) = 0;
  while IsFound do begin
    List.Add(SR.Name);
    IsFound := FindNext(SR) = 0;
  end;
  FindClose(SR);
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  DTTelnetServer.Controller(CtrlCode);
end;

{
Delphi 4 ve altý için:
function TDTTelnetServer.GetServiceController: PServiceController;
begin
  Result := @ServiceController;;
end;
}

function TDTTelnetServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;;
end;



procedure TDTTelnetServer.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  (* Sunucu Soket 1899 numaralý
     portu dinlemektedir.*)
  ServerSocket.Port := 1899;
  try
    ServerSocket.Active := True;
    Started := True;
    LogMessage('Basit Telnet Sunucu Hizmeti baþarýyla çalýþtý', EVENTLOG_INFORMATION_TYPE);
  except
    (* Bir hata durumunda Olay Loguna hatayý yaz ve hizmeti çalýþtýrma*)
    on E: Exception do
    begin
      Started := False;
      LogMessage(E.Message, EVENTLOG_ERROR_TYPE);
    end;
  end;
end;

procedure TDTTelnetServer.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  try
    (* Sunucu soketi kapat *)
    ServerSocket.Active := False;
    Stopped := True;
    LogMessage('Basit Telnet Sunucu Hizmeti durduruldu', EVENTLOG_INFORMATION_TYPE);
  except
    (* Bir hata durumunda Olay Loguna hatayý yaz ve hizmeti durdurma *)
    on E: Exception do
    begin
      Stopped := False;
      LogMessage(E.Message, EVENTLOG_ERROR_TYPE);
    end;
  end;
end;

procedure TDTTelnetServer.ServiceExecute(Sender: TService);
begin
  try
    while not Terminated do
    begin
      ServiceThread.ProcessRequests(True);
    end;
  except
    on E: Exception do
    begin
      LogMessage(E.Message, EVENTLOG_ERROR_TYPE);
    end;
  end;
end;

{ TClientInfo }

constructor TIstemciBilgi.Create(BaglantiZamani: TDateTime);
begin
  FZaman := BaglantiZamani;
  FAktifDizin := 'C:\';
  FSonKomut := '';
end;

procedure TDTTelnetServer.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Socket.Data := TIstemciBilgi.Create(Now);
  Socket.SendText('Merhaba ' + Socket.LocalHost + ' IP adresin ' + Socket.LocalAddress + #13#10);
  Socket.SendText('Komut Girin >');
end;

procedure TDTTelnetServer.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var IstemciBilgisi: TIstemciBilgi;
    Komut, Parametre: string;
    KomutTipi: TKomut;
    IslemYap: Boolean;
begin
  try
    (* Soket nesnesinden Istemci Bilgisini al *)
    IstemciBilgisi := TIstemciBilgi(Socket.Data);
    (* Ýstemcinin gönderdiði bilgiyi al *)
    Komut := Socket.ReceiveText;
    (* Gelen veriyi sakla *)
    IstemciBilgisi.SonKomut := IstemciBilgisi.SonKomut + Komut;
    (* Ýstemci <ENTER> tuþuna basmýþ mý ? *)
    IslemYap := Pos(#13, Komut) > 0;
    if IslemYap then
    begin
      Komut := IstemciBilgisi.SonKomut;
      IstemciBilgisi.SonKomut := '';
      (* Komutun ne olduðunu anla *)
      if KomutIsle(Komut, KomutTipi, Parametre) then
      begin
        (* Geçerli bir komut ise komutu çalýþtýr *)
        KomutCalistir(KomutTipi, Parametre, Socket);
      end else Socket.SendText('Geçersiz Komut: ' + Komut);
      (* Komut satýrýný gönder *)
      Socket.SendText(#13#10'Komut Girin >');
    end;
  except
    (* Hata durumunda olay loguna yaz *)
    on E: Exception do
    begin
      LogMessage(E.Message, EVENTLOG_ERROR_TYPE);
    end;
  end;
end;

function TDTTelnetServer.KomutIsle(Cmd: string; out Komut: TKomut;
  out Parametre: string): Boolean;
var I: TKomut;
    Temp: string;
 function ParametreBul: string;
 var BoslukPos: Integer;
 begin
   BoslukPos := Pos(' ', Cmd);
   if BoslukPos > 0 then
    Result := Trim(Copy(Cmd, BoslukPos + 1, Length(Cmd)))
   else Result := '';
 end;
begin
  Result := False;
  for I := Low(TKomut) to High(TKomut) do
  begin
    Temp := Copy(Cmd, 1, Length(Komutlar[I]));
    if CompareText(Temp, Komutlar[I]) = 0 then
    begin
      Komut := I;
      Parametre := ParametreBul;
      Result := True;
      Break;
    end;
  end;
end;

procedure TDTTelnetServer.KomutCalistir(Komut: TKomut;
  const Parametre: string; Soket: TCustomWinSocket);
var IstemciBilgisi: TIstemciBilgi;

 procedure YardimGonder;
 var I: TKomut;
 begin
   for I := Low(TKomut) to High(TKomut) do
    Soket.SendText(KomutYardimlar[I]+ #13#10);
 end;

 procedure ListeGonder;
 var List: TStringList;
     I: Integer;
 begin
   List := TStringList.Create;
   try
     FindFiles(IstemciBilgisi.AktifDizin, '*.*', List);
     for I := 0 to List.Count - 1 do
      Soket.SendText(List[I] + #13#10);
   finally
     List.Free;
   end;
 end;

 procedure DosyaGonder;
 var FS: TFileStream;
 begin
   FS := TFileStream.Create(IstemciBilgisi.AktifDizin + Parametre, fmOpenRead);
   try
     Soket.SendStream(FS);
   finally
     // FS.Free; -> Soket tarafýndan otomatik olarak yok edilecektir.
   end;
 end;

 procedure DurumGonder;
 begin
   with Soket do
   begin
     SendText('Lokal Makine Adý: ' + LocalHost + #13#10);
     SendText('Lokal IP Adresi : ' + LocalAddress + #13#10);
     SendText('Uzak Makine Adý : ' + RemoteHost + #13#10);
     SendText('Uzak IP Adresi  : ' + RemoteAddress + #13#10);
     SendText('Aktif baðlantý  : ' + IntToStr(ServerSocket.Socket.ActiveConnections) + #13#10);
   end;
 end;

begin
  IstemciBilgisi := TIstemciBilgi(Soket.Data);
  case Komut of
  kmYardim:
   begin
     YardimGonder;
   end;
  kmListe:
   begin
     ListeGonder;
   end;
  kmGoster:
   begin
     if FileExists(IstemciBilgisi.AktifDizin + Parametre) then
       DosyaGonder
     else Soket.SendText('Dosya bulunamadý:' + Parametre);
   end;
  kmCD:
   begin
     if Parametre = '' then
      Soket.SendText('Aktif dizin: ' + IstemciBilgisi.AktifDizin)
     else
     begin
       if DirectoryExists(Parametre) then
       begin
         if Parametre[Length(Parametre)] <> '\' then
           IstemciBilgisi.AktifDizin := Parametre + '\'
         else
           IstemciBilgisi.AktifDizin := Parametre
       end
      else
        Soket.SendText('Geçersiz dizin:' + Parametre);
     end;
   end;
  kmDurum:
   begin
     DurumGonder;
   end;
  kmCik:
   begin
     Soket.Close;
   end;
  end;
end;
procedure TDTTelnetServer.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  (* Baðlantý için nesne yaratýlmýþsa nesneyi yok et*)
  if Socket.Data <> nil then
   TIstemciBilgi(Socket.Data).Free;
end;

end.

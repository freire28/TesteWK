unit Pessoa;

interface

uses Endereco;

type TPessoa = class
  private
    FidPessoa: integer;
    Fflnatureza: integer;
    Fnmprimeiro: String;
    Fdtregistro: Tdatetime;
    Fnmsegundo: string;
    Fdsdocumento: String;
    Fendereco: TEndereco;
    procedure SetidPessoa(const Value: integer);
    procedure Setflnatureza(const Value: integer);
    procedure Setdsdocumento(const Value: String);
    procedure Setdtregistro(const Value: Tdatetime);
    procedure Setnmprimeiro(const Value: String);
    procedure Setnmsegundo(const Value: string);
    procedure Setendereco(const Value: TEndereco);

  public
    Constructor Create;
    destructor destroy;

    property idPessoa: integer read FidPessoa write SetidPessoa;
    property flnatureza :integer  read Fflnatureza write Setflnatureza;
    property dsdocumento : String read Fdsdocumento write Setdsdocumento;
    property nmprimeiro:String read Fnmprimeiro write Setnmprimeiro;
    property nmsegundo:string read Fnmsegundo write Setnmsegundo;
    property dtregistro:Tdatetime read Fdtregistro write Setdtregistro;
    property endereco:TEndereco read Fendereco write Setendereco;

end;

implementation

{ TPessoa }

constructor TPessoa.Create;
begin
  endereco := TEndereco.Create;
end;

destructor TPessoa.destroy;
begin
  endereco.Free;
end;

procedure TPessoa.Setdsdocumento(const Value: String);
begin
  Fdsdocumento := Value;
end;

procedure TPessoa.Setdtregistro(const Value: TDatetime);
begin
  Fdtregistro := Value;
end;

procedure TPessoa.Setendereco(const Value: TEndereco);
begin
  Fendereco := Value;
end;

procedure TPessoa.Setflnatureza(const Value: integer);
begin
  Fflnatureza := Value;
end;

procedure TPessoa.SetidPessoa(const Value: integer);
begin
  FidPessoa := Value;
end;

procedure TPessoa.Setnmprimeiro(const Value: String);
begin
  Fnmprimeiro := Value;
end;

procedure TPessoa.Setnmsegundo(const Value: string);
begin
  Fnmsegundo := Value;
end;

end.

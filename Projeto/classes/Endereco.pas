unit Endereco;

interface

uses EnderecoIntegracao;

type
  TEndereco = class
  private
    FidEndereco: integer;
    Fdscep: String;
    FidPessoa: integer;
    FendIntegracao: TEnderecoIntegracao;
    procedure Setdscep(const Value: String);
    procedure SetidEndereco(const Value: integer);
    procedure SetidPessoa(const Value: integer);
    procedure SetendIntegracao(const Value: TEnderecoIntegracao);
  public
    Constructor Create;
    destructor Destroy;

    property idEndereco: integer read FidEndereco write SetidEndereco;
    property idPessoa: integer read FidPessoa write SetidPessoa;
    property dscep: String read Fdscep write Setdscep;
    property endIntegracao: TEnderecoIntegracao read FendIntegracao
      write SetendIntegracao;
  end;

implementation

{ TEndereco }

constructor TEndereco.Create;
begin
  endIntegracao := TEnderecoIntegracao.Create;
end;

destructor TEndereco.Destroy;
begin
  endIntegracao.Free;
end;

procedure TEndereco.Setdscep(const Value: String);
begin
  Fdscep := Value;
end;

procedure TEndereco.SetendIntegracao(const Value: TEnderecoIntegracao);
begin
  FendIntegracao := Value;
end;

procedure TEndereco.SetidEndereco(const Value: integer);
begin
  FidEndereco := Value;
end;

procedure TEndereco.SetidPessoa(const Value: integer);
begin
  FidPessoa := Value;
end;

end.

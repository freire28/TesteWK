unit EnderecoIntegracao;

interface

type TEnderecoIntegracao = class
  private
    Flogradouro: String;
    Fibge: String;
    Fbairro: String;
    Fddd: String;
    Fuf: String;
    Fcep: String;
    Fsiafi: String;
    Flocalidade: String;
    Fcomplemento: String;
    Fgia: String;
    procedure Setbairro(const Value: String);
    procedure Setcep(const Value: String);
    procedure Setcomplemento(const Value: String);
    procedure Setddd(const Value: String);
    procedure Setgia(const Value: String);
    procedure Setibge(const Value: String);
    procedure Setlocalidade(const Value: String);
    procedure Setlogradouro(const Value: String);
    procedure Setsiafi(const Value: String);
    procedure Setuf(const Value: String);

  public
      Constructor Create;
      Destructor destroy;
    property cep:String read FCep write fCep;
    property logradouro:String read Flogradouro write Setlogradouro;
    property complemento:String read Fcomplemento write Setcomplemento;
    property bairro:String read Fbairro write Setbairro;
    property localidade:String read Flocalidade write Setlocalidade;
    property uf:String read Fuf write Setuf;
    property ibge:String read Fibge write Setibge;
    property gia:String read Fgia write Setgia;
    property ddd:String read Fddd write Setddd;
    property siafi:String read Fsiafi write Setsiafi;

end;

implementation

{ TEnderecoIntegracao }

constructor TEnderecoIntegracao.Create;
begin
  inherited;
end;

destructor TEnderecoIntegracao.destroy;
begin
  inherited;
end;

procedure TEnderecoIntegracao.Setbairro(const Value: String);
begin
  Fbairro := Value;
end;

procedure TEnderecoIntegracao.Setcep(const Value: String);
begin
  Fcep := Value;
end;

procedure TEnderecoIntegracao.Setcomplemento(const Value: String);
begin
  Fcomplemento := Value;
end;

procedure TEnderecoIntegracao.Setddd(const Value: String);
begin
  Fddd := Value;
end;

procedure TEnderecoIntegracao.Setgia(const Value: String);
begin
  Fgia := Value;
end;

procedure TEnderecoIntegracao.Setibge(const Value: String);
begin
  Fibge := Value;
end;

procedure TEnderecoIntegracao.Setlocalidade(const Value: String);
begin
  Flocalidade := Value;
end;

procedure TEnderecoIntegracao.Setlogradouro(const Value: String);
begin
  Flogradouro := Value;
end;

procedure TEnderecoIntegracao.Setsiafi(const Value: String);
begin
  Fsiafi := Value;
end;

procedure TEnderecoIntegracao.Setuf(const Value: String);
begin
  Fuf := Value;
end;

end.

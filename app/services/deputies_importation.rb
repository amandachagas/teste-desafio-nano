class DeputiesImportation < Service
  require 'csv'

  CSV_HEADER = {
    "txNomeParlamentar": 0,
    "cpf": 1,
    "ideCadastro": 2,
    "nuCarteiraParlamentar": 3,
    "nuLegislatura": 4,
    "sgUF": 5,
    "sgPartido": 6,
    "codLegislatura": 7,
    "numSubCota": 8,
    "txtDescricao": 9,
    "numEspecificacaoSubCota": 10,
    "txtDescricaoEspecificacao": 11,
    "txtFornecedor": 12,
    "txtCNPJCPF": 13,
    "txtNumero": 14,
    "indTipoDocumento": 15,
    "datEmissao": 16,
    "vlrDocumento": 17,
    "vlrGlosa": 18,
    "vlrLiquido": 19,
    "numMes": 20,
    "numAno": 21,
    "numParcela": 22,
    "txtPassageiro": 23,
    "txtTrecho": 24,
    "numLote": 25,
    "numRessarcimento": 26,
    "vlrRestituicao": 27,
    "nuDeputadoId": 28,
    "ideDocumento": 29,
    "urlDocumento": 30
  }.freeze

  ALLOWED_UF = 'BA'.freeze

  attr_accessor :storage_path

  def initialize(args)
    self.storage_path = args[:storage_path]
  end

  def call
    ActiveRecord::Base.transaction do
      # hash of deputies by cpf
      # not optimized as it get all deputies
      # however its only require one database call
      all_deputies = {}
      Deputy.all.each do |deputy|
        all_deputies[deputy.cpf] = deputy
      end

      CSV.foreach(storage_path, encoding: "bom|utf-8", headers: true) do |row|
        # return when UF is not BA
        next if row[CSV_HEADER[:sgUF]] != ALLOWED_UF

        # return if there is no cpf
        next unless row[CSV_HEADER[:cpf]]

        create_deputy(row, all_deputies)
        create_invoice(row, all_deputies)
      end
    end
  end

  private

  def create_deputy(row, all_deputies)
    # do not create deputies already created
    return if all_deputies[row[CSV_HEADER[:cpf]]]

    deputy_args = {
      full_name: row[CSV_HEADER[:txNomeParlamentar]],
      cpf: row[CSV_HEADER[:cpf]],
      political_party: row[CSV_HEADER[:sgPartido]],
      registered_id: row[CSV_HEADER[:ideCadastro]]
    }

    deputy = Deputy.create(deputy_args)

    all_deputies[row[CSV_HEADER[:cpf]]] = deputy
  end

  def create_invoice(row, all_deputies)
    invoice = {
      description: row[CSV_HEADER[:txtDescricao]],
      provider: row[CSV_HEADER[:txtFornecedor]],
      provider_cnpj: row[CSV_HEADER[:txtCNPJCPF]],
      issue_date: row[CSV_HEADER[:datEmissao]],
      net_value: row[CSV_HEADER[:vlrLiquido]],
      document_url: row[CSV_HEADER[:urlDocumento]],
      deputy_id: all_deputies[row[CSV_HEADER[:cpf]]].id
    }

    Invoice.create(invoice)
  end
end

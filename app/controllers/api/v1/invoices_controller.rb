class Api::V1::InvoicesController < Api::V1::ApiController
  protect_from_forgery with: :null_session

  # GET /api/v1/invoices
  def index
    render json: format_json(invoices)
  end
  
  # GET /api/v1/invoices/:id
  def show
    render json: format_json(invoice)
  end

  # POST /api/v1/invoices
  def create
    invoice = Deputy.new(allowed_list_params)

    if invoice.save
      render json: invoice
    else
      render json: errors(invoice), status: 422
    end
  end

  # PATCH /api/v1/invoices/:id
  def update
    if invoice.update(allowed_list_params)
      render json: invoice
    else
      render json: errors(invoice), status: 422
    end
  end

  # DELETE /api/v1/invoices/:id
  def destroy
    if invoice.destroy
      head :no_content
    else
      render json: errors(invoice), status: 422
    end
  end

  private

  def format_json(obj)
    obj.as_json
  end

  # Get all invoices
  def invoices
    @invoices ||= Invoice.all
  end

  # Get a specific invoice
  def invoice
    @invoice ||= Invoice.find(params[:id])
  end

  def allowed_list
      %i[description provider provider_cnpj issue_date net_value document_id document_url deputy_id]
  end

  def allowed_list_params
      params.require(:invoice).permit(allowed_list)
  end

  # Errors
  def errors(record)
    { errors: record.errors.messages }
  end
end

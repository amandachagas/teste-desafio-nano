class Api::V1::DeputiesController < Api::V1::ApiController
  include Api::V1::Concerns::ImportableFromCsvController
  
  protect_from_forgery with: :null_session

  # GET /api/v1/deputies
  def index
    render json: format_json(deputies)
  end
  
  # GET /api/v1/deputies/:id
  def show
    render json: format_json(deputy)
  end

  # POST /api/v1/deputies
  def create
    deputy = Deputy.new(allowed_list_params)

    if deputy.save
      render json: deputy
    else
      render json: errors(deputy), status: 422
    end
  end

  # PATCH /api/v1/deputies/:id
  def update
    if deputy.update(allowed_list_params)
      render json: deputy
    else
      render json: errors(deputy), status: 422
    end
  end

  # DELETE /api/v1/deputies/:id
  def destroy
    if deputy.destroy
      head :no_content
    else
      render json: errors(deputy), status: 422
    end
  end

  private

  def format_json(obj)
    obj.as_json(methods: :sum_invoices_net_values, include: :invoices)
  end

  # Get all deputies
  def deputies
    @deputies ||= Deputy.all
  end

  # Get a specific deputy
  def deputy
    @deputy ||= Deputy.find(params[:id])
  end

  def allowed_list
      %i[full_name cpf political_party registered_id]
  end

  def allowed_list_params
      params.require(:deputy).permit(allowed_list)
  end

  # Errors
  def errors(record)
    { errors: record.errors.messages }
  end
end

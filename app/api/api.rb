class API < Grape::API
  prefix 'api'
  version 'v0', using: :path
  format :json
  rescue_from :all do |e|
    error_response({ message: e.message })
  end

  ALLOWED_PARAMS = [:title, :feasibility, :motivation, :scale].freeze

  helpers do
    def allowed_params
      ActionController::Parameters.new(params).permit(ALLOWED_PARAMS)
    end

    params :allow_title do requires :title, type: String end
    params :allow_feasibility do requires :feasibility, type: Integer end
    params :allow_motivation do requires :motivation, type: Integer end
    params :allow_scale do requires :scale, type: Integer end
  end

  resource :items do
    get do
      Item.all
    end

    get ':id' do
      Item.find(params[:id])
    end

    put ':id' do
      params { use :allow_title, :allow_feasibility, :allow_motivation, :allow_scale }
      # sleep 0.25
      Item.find(params[:id]).update!(allowed_params)
    end
  end
end


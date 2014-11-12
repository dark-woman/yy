class API < Grape::API
  prefix 'api'
  version 'v0', using: :path
  format :json
  rescue_from :all do |e|
    error_response({ message: e.message })
  end

  ALLOWED_PARAMS = [:title, :detail, :feasibility, :motivation, :scale].freeze

  helpers do
    def allowed_params
      ActionController::Parameters.new(params).permit(ALLOWED_PARAMS)
    end
  end

  resource :items do
    get do
      Item.all
    end

    get ':id' do
      Item.find(params[:id])
    end

    post 'new' do
      Item.create(allowed_params)
    end

    put ':id' do
      Item.find(params[:id]).update!(allowed_params)
    end

    delete ':id' do
      Item.find(params[:id]).destroy
    end
  end
end


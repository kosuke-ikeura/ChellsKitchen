class FlavorsController < ApplicationController
    before_action :authenticate_user!
    def index
        @flavors = Flavor.where(id:2..25).order(id: "ASC").page(params[:page]).per(10)
        @StatusImage = ["", "urn_red.png", "urn_yellow.png", "urn_blue.png"]
        @test = Flavor.find_by(id: 26)
    end
    def new
        @flavor = Flavor.new
    end
    def create
        @flavor = Flavor.new(flavor_params)
        @flavor.save
        redirect_to flavors_path
    end
    
    private
    def flavor_params
    	params.require(:flavor).permit(:name, :purchase_price, :image, :image_cache, :status).merge(user_id: current_user.id) 
    end
end

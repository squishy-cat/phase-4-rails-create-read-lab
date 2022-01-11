class PlantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    #GET /plants
    def index
        plants = Plant.all
        render json: plants
    end
    
    #GET /plants/:id 
    def show
        plant = find_plant
        render json: plant
    end

    #POST /plants
    def create
        plant = Plant.create(plant_params)
        render json: plant, status: :created
    end

    private

    def plant_params
        params.permit(:name, :image, :price)
    end

    def find_plant
        Plant.find(params[:id])
    end
    
    def render_not_found_response
        render json: { error: "Plant not found" }, status: :not_found
    end
end
module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :restaurant_params, only: [:show]
      def index
        restaurants = Restaurant.all

        render json: {
          restaurants: restaurants
        }, status: :ok
      end

      def show 
        render json:{
          restaurant: @restaurant
        }, stauts: :ok
      end

      private

      def restaurant_params
        @restaurant = Restaurant.find(params[:id])
      end
      
    end
  end
end
module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :restaurant_params, only: [:show]
      def index
        restaurants = Restaurant.all
        restaurant_array = restaurants.map { |restaurant| {
          id: restaurant.id,
          name: restaurant.name,
          fee: restaurant.fee,
          time_required: restaurant.time_required
        }}

        render json: restaurant_array, status: :ok
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
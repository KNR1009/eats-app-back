module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :restaurant_param, only: [:show]
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

      def create
        restaurant = Restaurant.new(restaurant_params)
        if restaurant.save
          render json: {
            id: restaurant.id,
            name: restaurant.name,
            message: "成功しました"
          }, status: 200
        else
          render json: {message: "レストランの新規作成に成功しました"}
        end

      end

      def show 
        render json:{
          restaurant: @restaurant
        }, stauts: :ok
      end

      private

      def restaurant_param
        @restaurant = Restaurant.find(params[:id])
      end

      def restaurant_params
        params.permit(:name, :fee, :time_required)
      end
      
    end
  end
end
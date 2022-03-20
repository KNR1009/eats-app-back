module Api
  module V1
    class FoodsController < ApplicationController
      before_action :restaurant_param, only: [:show]
      # 店舗の商品一覧
      def index
        restaurant = Restaurant.find(params[:restaurant_id])
        foods = restaurant.foods
        render json:{
          foods: foods
        }, status: :ok
      end

      def show
        render json: {
          food: @food
        }, status: :ok
      end

      private
      def restaurant_param
        restaurant = Restaurant.find(params[:restaurant_id])
        @food = restaurant.foods.find(params[:id])
      end

    end
  end
end
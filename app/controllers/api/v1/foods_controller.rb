module Api
  module V1
    class FoodsController < ApplicationController
      before_action :restaurant_param, only: [:show]
      before_action :food_param, only: [:create]
      # 店舗の商品一覧
      def index
        restaurant = Restaurant.find(params[:restaurant_id])
        foods = restaurant.foods
        foods_array = foods.map{|food| {
          id: food.id,
          name: food.name,
          price: food.price,
          description: food.description
        }}
        render json: foods_array, status: :ok
      end
      
      def create
        food = Food.new(food_param)
        if food.save
          render json: {name: food.name, message: "登録しました"}
        else
          render json: {message: "登録失敗しました"}
        end
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
      # 新規作成
      def food_param
        params.permit(:name, :price, :description, :restaurant_id)
      end
    end
  end
end
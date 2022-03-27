module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create replace]
      def index
        line_foods = LineFood.active
        if line_foods.exists?
          render json:{
            line_foods_ids: line_foods.map{ |line_food| line_food.id },
            restaurant: line_foods[0].restaurant.name,
            count: line_foods.map{ |line_food| line_food.count }.inject(:+),
            amount: line_foods.map{ |line_food| line_food.food.price }.inject(:+)
          }
        else 
          render json: {}, status: :no_contents
        end
  
      end

      def create
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          return render json: {
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            new_restaurant: @ordered_food.restaurant.name
          }, status: :not_acceptable
        end

        set_line_food(@ordered_food)

        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      # TODO: 以下を完成させる
      def replace
        return render json: LineFood.active.other_restaurant(@ordered_food.restaurant.id)
        # LineFood.active.other_restaurant(@ordered_food.restaurant.id).each do |line_food|
        #   line_food.update_attribute(:active, false)
        # end

        # set_line_food(@ordered_food)

        # if @line_food.save
        #   render json: {
        #     line_food: @line_food
        #   }, status: :created
        # else
        #   render json: {}, status: :internal_server_error
        # end
      end

      private

      def set_food
        @ordered_food = Food.find(params[:food_id])
      end

      def set_line_food(ordered_food)
        if ordered_food.line_food.present?
          @line_food = ordered_food.line_food
          @line_food.attributes = {
            count: ordered_food.line_food.count.to_i + params[:count].to_i,
            active: true
          }
        else 
          @line_food = ordered_food.build.line_food({
            count: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          })
        end
      end
    end
  end
end

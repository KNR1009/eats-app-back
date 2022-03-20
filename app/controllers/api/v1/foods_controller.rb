module Api
  module V1
    class FoodsController < ApplicationController
      def index
        foods = Food.all
        render json: {
          foods:  foods
        }, status: :ok
      end

    end

    private

  end
end
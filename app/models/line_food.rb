class LineFood < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  belongs_to :order, optional: true

  validates :count, numericality: { greater_than: 0 }

  # activeの値だけを取得
  scope :active, -> { where(active: true) }
  # 他店舗のレストランがあるかのチェック
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id) }

  # 商品の合計金額を算出
  def total_amount
    food.price * count
  end
end
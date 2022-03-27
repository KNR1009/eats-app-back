Rails.application.routes.draw do
  # --- ここから追加 ---
  namespace :api do
    namespace :v1 do
      resources :restaurants do
        resources :foods, only: [:index, :show]
      end
      resources :line_foods, only: [:index, :create]
      put 'line_foods/replace', to: 'line_foods#replace'
    end
  end
  # --- ここまで追加 ---
end
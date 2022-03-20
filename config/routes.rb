Rails.application.routes.draw do
  # --- ここから追加 ---
  namespace :api do
    namespace :v1 do
      resources :restaurants do
        resources :foods, only: [:index, :show]
      end
    end
  end
  # --- ここまで追加 ---
end
Rails.application.routes.draw do
  # --- ここから追加 ---
  namespace :api do
    namespace :v1 do
      resources :restaurants do
        resources :foods, only:%i[index]
      end
    end
  end
  # --- ここまで追加 ---
end
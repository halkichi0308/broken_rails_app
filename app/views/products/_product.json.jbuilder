json.extract! product, :id, :title, :info, :value, :img_path, :created_at, :updated_at
json.url product_url(product, format: :json)

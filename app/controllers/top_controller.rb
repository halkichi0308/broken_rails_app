class TopController < ApplicationController
  class ModelHelper
    @@model_name = nil
    def initialize(model_name)
      @@model_name = model_name
    end
    def get_name(i)
      return Module.const_get(@@model_name.classify).columns[i].name
    end
    def get_length
      return Module.const_get(@@model_name.classify).columns.length
    end
    def get_column_type(i)
      return Module.const_get(@@model_name.classify).columns[i].type
    end
  end
  def index
    @reviews = Review.all.order(id: 'DESC')
    @per_count = 3
    @products = Product.page(params[:page]).per(@per_count).order(:id)
  end
end

class CartController < ApplicationController
  before_action :cart_empty_check
  
  def index
    if params[:delete] && params[:delete].length < 5
      session[:cartItem].delete_at(params[:delete].to_i)
    end
    @products = in_cart_products
  end

  def cart
    if params[:id]
      session[:cartItem] += [params[:id]]
      redirect_to cart_path, notice: 'You have added products to your cart.' and return
    else
      redirect_to cart_path and return
    end
  end
  
  def submit
    unless user_signed_in?
      redirect_to new_user_session_path(redirect: cart_path), notice: 'Please Login.'
      return 
    end
    @products = Product.all
    purchase_details = []
    total_value = 0
    session[:cartItem].each_with_index do |product_id, i|

      # [vulnerability]: SQLi
      # [Safe pattern]:
      # product = Product.find_by('id: product_id')
      product = Product.find_by("id=#{product_id}")

      purchase_details[i] = {
        :title => product.title,
        :value => product.value
      }
      total_value += product.value
    end

    history = History.new(
      user_id: current_user.id,
      user_name: current_user.email,
      details: purchase_details.to_json,
      total_value: total_value
      )
    history.save

    #session clear
    session[:cartItem] = []
    
    redirect_to mypage_index_path, notice: 'Product purchased.'
    
  end

  private
  def cart_empty_check
    if session[:cartItem].blank?
      session[:cartItem] = []
    end
  end


  def in_cart_products
    products = []
    
    # [Note]: N+1 Problem.
    # [Safe pattern]:
    # products = Product.all.find(session[:cartItem])
    session[:cartItem].each_with_index do |product_id, i|
      product = Product.find_by(id: product_id)
      products.push product
    end
    products
  end

end

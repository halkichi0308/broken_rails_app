class CartController < ApplicationController
  
  def index
    @products = Product.all
    if params[:delete] && params[:delete].length < 5
      session[:cartItem].delete_at(params[:delete].to_i)
    end
  end
  def cart
    if session[:cartItem].blank?
      session[:cartItem] = []
    end
    # ここで数値チェックを外せばSQLインジェクション
    #if params[:id] =~ /^[0-9]{0,}$/
    if params[:id]
      session[:cartItem] += [params[:id]]
      flash[:notice] = "商品をカートに追加しました。"
      redirect_to cart_path and return
    else
      redirect_to cart_path and return
    end
  end
  
  def submit
    unless user_signed_in?
      flash[:notice] = "ログインしてください。"
      redirect_to "#{new_user_session_path}?redirect=#{cart_path}"
      return 
    end
    @products = Product.all
    purchase_details = []
    total_value = 0
    session[:cartItem].each_with_index do |product_id, i|

      #[vulnerability]: SQLi
      #[Safe pattern]:
      #product = Product.find_by('id: product_id')

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
    
    flash[:notice] = "商品を購入しました。"
    redirect_to mypage_index_path
    
  end
  def confirm
    @products = Product.all
  end
end

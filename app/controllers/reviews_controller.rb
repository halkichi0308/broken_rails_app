class ReviewsController < ApplicationController
  #[vulnerability]: CSRF
  #[Safe pattern]:
  #Comment out protect _ from _ forgery
  protect_from_forgery except: [:create, :delete]

  def create
    unless user_signed_in?
      flash[:notice] = "ログインしてください。"
      redirect_to new_user_session_path, redirect: request.url and return
    end
    
    if params[:content].blank?
      flash[:notice] = "レビューを入力してください"
    else
      review = Review.new(
                  product_id: params[:product_id],
                  user_name: current_user.email,
                  content: params[:content]
                )
      review.save
      flash[:notice] = "レビューを送信しました。"
    end

    redirect_to product_path(params[:product_id])
    return
  end
  def list
    unless params[:delete].blank?
      review = Review.find params[:delete]
      if current_user.email == review.user_name
        review.destroy
        flash[:notice] = "レビューを取り消しました。"
        redirect_to product_path(params[:product_id]) and return
      end
    end
    redirect_to product_path(params[:product_id]) and return
  end
end

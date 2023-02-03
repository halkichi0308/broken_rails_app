class ReviewsController < ApplicationController
  #[vulnerability]: CSRF
  #[Safe pattern]:
  #Comment out protect _ from _ forgery
  protect_from_forgery except: [:create, :delete]

  def index
    redirect_to product_path(params[:product_id])
  end

  def create
    unless user_signed_in?
      redirect_to new_user_session_path(redirect: request.url), notice: 'Please Login.' and return
    end
    
    if params[:content].blank?
      flash[:notice] = I18n.t('review.error.blank')
    else
      review = Review.new(
                  product_id: params[:product_id],
                  user_name: current_user.email,
                  content: params[:content]
                )
      review.save
      flash[:notice] = I18n.t('review.success.submit')
    end

    redirect_to product_path(params[:product_id])
    return
  end
  def list
    unless params[:delete].blank?
      review = Review.find(params[:delete])
      review.destroy
      redirect_to product_path(params[:product_id]), notice: I18n.t('review.success.delete') and return
    end
    redirect_to product_path(params[:product_id]) and return
  end
end

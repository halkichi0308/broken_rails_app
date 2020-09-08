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
      flash[:notice] = 'Please fill in the review.'
    else
      review = Review.new(
                  product_id: params[:product_id],
                  user_name: current_user.email,
                  content: params[:content]
                )
      review.save
      flash[:notice] = 'Review has been submitted.'
    end

    redirect_to product_path(params[:product_id])
    return
  end
  def list
    unless params[:delete].blank?
      review = Review.find params[:delete]
      if current_user.email == review.user_name
        review.destroy
        redirect_to product_path(params[:product_id]), notice: 'The review has been deleted.' and return
      end
    end
    redirect_to product_path(params[:product_id]) and return
  end
end

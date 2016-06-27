class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  
  def new
    @review = Review.new
  end
  
  def create
    @review=Review.new(review_params)
    @review.book_id=@book.id
    @review.user_id=current_user.id
    
    if @review.save
      redirect_to book_path(@book)
    else
      reder 'new'
    end
    
  end
  
  
  def edit
  end
  
  def update
      if @review.update(review_params)
        redirect_to book_path(@book)
      else
        render 'edit'
      end
  end
  
  def destroy
    @review.destroy
    redirect_to book_path(@book)
  end
  
  
  private
  def review_params
    params.require(:review).permit(:rating, :comment)
  end
  
  def find_book
    @book = Book.find(params[:book_id]) #we specify :book_id instead of just :id becasue we are in the reviews controller and a review is associated with a book_id
  end
  
  
  def find_review
      @review= Review.find(params[:id])
  end
  
end

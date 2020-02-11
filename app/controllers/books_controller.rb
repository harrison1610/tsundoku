class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    @book.tags.build
  end

  def create
    @book = current_user.books.create(book_params)

    flash[:notice] = "投稿しました"
    redirect_to root_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      @book.update(book_params)

      flash[:notice] = "投稿を更新しました"
      redirect_to root_path
    else
      render :edit
      binding.pry
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.user_id == current_user.id
      book.destroy

      flash[:notice] = "投稿を削除しました"
      redirect_to root_path
    else

    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private
  def book_params
    params.require(:book).permit( :title, :content, tags_attributes: [:id, :book_id, :tag])
  end

end

class Admin::GenresController < ApplicationController

  before_action :authenticate_admin!

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "新しいジャンルを登録しました。"
      redirect_to admin_genres_path
    else
      render :index
    end
  end

  def index
    @genres = Genre.page(params[:page])
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      flash[:notice] = "変更内容を更新しました。"
      redirect_to admin_genres_path
    else
      render "edit"
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end

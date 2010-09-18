class PostsController < ApplicationController
  def index
    @posts = Post.roots
  end

  def create
    @post = Post.new params[:post]
    @post.user = current_user
    @post.save

    redirect_to posts_path
  end

  def destroy
    Post.find(params[:id]).destroy if current_user.try :admin

    redirect_to posts_path
  end

  def search
    @posts = Post.all :conditions => ['content like ?', "%#{params[:search]}%"]
    render :index
  end

end

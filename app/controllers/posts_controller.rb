class PostsController < ApplicationController
  def index
    @posts = Post.roots.newest_first.with_cheers
    @users = User.by_cheers
  end

  def create
    redirect_to posts_path

    return unless logged_in?
    @post = Post.new params[:post]
    @post.user = current_user
    @post.save
  end

  def destroy
    Post.find(params[:id]).destroy if current_user.try :is_admin?

    redirect_to posts_path
  end

  def search
    @posts = Post.newest_first.with_cheers.all :conditions => ['content like ?', "%#{params[:search]}%"]
    @searching = true
    render :index
  end

end

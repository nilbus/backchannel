class CheersController < ApplicationController
  def create
    # render nothing regardless
    render :js => ''
    
    # make sure they're logged in
    return unless logged_in?
    
    # make sure the post is real
    return unless @post = Post.find(params[:post_id])
    
    # make sure they haven't cheered it already
    return unless Cheer.first(:conditions => {:user_id => current_user.id, :post_id => params[:post_id]}).nil?

    # make sure they aren't cheering their own post
    return unless Post.first(:conditions => {:id => params[:post_id], :user_id => current_user.id}).nil?

    # cheer the post
    Cheer.create :post_id => params[:post_id], :user_id => current_user.id
  end

  def destroy
    # render nothing regardless
    render :js => ''

    # make sure they're logged in
    return unless logged_in?

    # make sure they cheered the post. Normally there's only one cheer, but in case of a race condition, kill them all
    return unless (@cheers = Cheer.all(:conditions => {:user_id => current_user.id, :post_id => params[:post_id]})).any?

    # goodbye!
    @cheers.each &:destroy
  end

end

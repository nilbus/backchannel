class UsersController < ApplicationController
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error]  = "We couldn't set up that account, sorry."
      render :action => 'new'
    end
  end

  def destroy
    unless current_user.try :is_admin? and User.find_by_id(params[:id]).try :destroy
      flash[:error] = "I guess you can't do that"
    end
    redirect_to '/'
  end

  def promote
    unless current_user.try :is_admin? and User.find_by_id(params[:id]).update_attribute :admin, true
      flash[:error] = "I guess you can't do that"
    end
    redirect_to '/'
  end

  def demote
    unless current_user.try :is_admin? and User.find_by_id(params[:id]).update_attribute :admin, false
      flash[:error] = "I guess you can't do that"
    end
    redirect_to '/'
  end
end

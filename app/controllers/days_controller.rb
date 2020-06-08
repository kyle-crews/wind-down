class DaysController < ApplicationController

  # lets user view log days if logged in
  get '/days' do
    if logged_in?
      @days = current_user.days.all
      erb :'days/days'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user create a blank day
  post '/days' do
    if params[:name].empty?
      flash[:message] = "Please Enter a Day Name"
      redirect_to_days
    else
      @user = current_user
      @day = Day.create(name:params[:name], user_id:@user.id)
      redirect_to_days
    end
  end

  # displays a single day
  get '/days/:id' do
    if logged_in?
      @day = Day.find(params[:id])
      erb :'days/show_day'
    else
      redirect_if_not_logged_in
    end
  end

  # lets a user view day edit form if they are logged in
  # does not let a user edit a day not created by it self
  get '/days/:id/edit' do
    if logged_in?
      @day = Day.find(params[:id])
      if @day.user_id == current_user.id
        erb :'days/edit_day'
      else
        redirect_to_days
      end
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user edit a day with blank content
  patch '/days/:id' do
    if !params[:name].empty?
      @day = Day.find(params[:id])
      @day.update(name:params[:name])
      flash[:message] = "Your day has been updated successfully"
      redirect_to_days
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/days/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own day if they are logged in
  # does not let a user delete a day they did not create
  delete '/days/:id/delete' do
    if logged_in?
      if current_user.days.size == 1
        flash[:message] = "You need at least one day"
        redirect_to_days
      else
        @day = Day.find(params[:id])
        if @day.user_id == current_user.id
          @day.destroy
          flash[:message] = "Your day has been deleted successfully"
          redirect_to_days
        end
      end
    else
      redirect_if_not_logged_in
    end
  end

  # helper route created to edit logs when the erb
  # file adds '/days' to the edit link
  get '/days/logs/:id/edit' do
    if logged_in?
      @log = Log.find(params[:id])
      @day = Day.find(@log.day_id)
      if @log.user_id == session[:user_id]
        erb :'logs/edit_log'
      else
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

end

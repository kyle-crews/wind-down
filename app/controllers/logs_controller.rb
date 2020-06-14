class LogsController < ApplicationController

  # lets a user view all logs if logged in
  # redirects to login page if not logged in
  get '/logs' do
    if logged_in?
      erb :'logs/logs'
    else
      redirect_if_not_logged_in
    end
  end

  # lets user create a log if they are logged in
  get '/logs/new' do
    if logged_in?
      erb :'/logs/create_log'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user create a blank log
  post '/logs' do
    if params[:good].empty? || params[:accomplishment].empty? || params[:date].empty? || params[:day_name].empty?
      flash[:message] = "Please don't leave blank content"
      redirect to "/logs/new"
    else
      @user = current_user
      @day = @user.days.find_or_create_by(name:params[:day_name])
      @day.user_id = @user.id
      @log = Log.create(good:params[:good], accomplishment:params[:accomplishment], date:params[:date], day_id:@day.id, user_id:@user.id)
      redirect to "/logs/#{@log.id}"
    end
  end

  # displays a single log
  get '/logs/:id' do
    if logged_in?
      @log = Log.find(params[:id])
      erb :'logs/show_log'
    else
      redirect_if_not_logged_in
    end
  end

  # lets a user view log edit form if they are logged in
  # does not let a user edit a log he/she did not create
  get '/logs/:id/edit' do
    if logged_in?
      @log = Log.find(params[:id])
      @day = Day.find(@log.day_id)
      if @log.user_id == current_user.id
        erb :'logs/edit_log'
      else
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user edit a text with blank content
  patch '/logs/:id' do
    if !params[:good].empty? && !params[:accomplishment].empty? && !params[:date].empty?
      @log = Log.find(params[:id])
      @log.update(good:params[:good], accomplishment:params[:accomplishment], date:params[:date])
      @day = current_user.days.find_by(name:params[:day_name])
      @log.day_id = @day.id
      @log.save
      flash[:message] = "Your Log Has Been Succesfully Updated"
      redirect_to_home_page
    else
      flash[:message] = "Please Don't Leave Blank Content"
      redirect to "/logs/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own log if they are logged in
  # does not let a user delete a log they did not create
  delete '/logs/:id/delete' do
    if logged_in?
      @log = Log.find(params[:id])
      if @log.user_id == current_user.id
        @log.delete
        flash[:message] = "Your log has been deleted successfully"
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

end

class TasksController < ApplicationController

# lets a user view all tasks if logged in
# redirects to login page if not logged in
  get '/tasks' do
    if logged_in?
      erb :'tasks/tasks'
    else
      redirect_if_not_logged_in
    end
  end

  # lets user create a task if they are logged in
  get '/tasks/new' do
    if logged_in?
      erb :'/tasks/create_task'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user create a blank task
  post '/tasks' do
    if params[:description].empty? || params[:amount].empty? || params[:date].empty? || params[:log_name].empty?
      flash[:message] = "Please don't leave blank content"
      redirect to "/tasks/new"
    else
      @user = current_user
      @log = @user.logs.find_or_create_by(name:params[:log_name])
      @log.user_id = @user.id
      @task = Task.create(description:params[:description], amount:params[:amount], date:params[:date], log_id:@log.id, user_id:@user.id)
      redirect to "/tasks/#{@task.id}"
    end
  end

  # displays a single task
  get '/tasks/:id' do
    if logged_in?
      @task = Task.find(params[:id])
      erb :'tasks/show_task'
    else
      redirect_if_not_logged_in
    end
  end

  # lets a user view task edit form if they are logged in
  # does not let a user edit a task he/she did not create
  get '/tasks/:id/edit' do
    if logged_in?
      @task = Task.find(params[:id])
      @log = Log.find(@task.log_id)
      if @task.user_id == current_user.id
        erb :'tasks/edit_task'
      else
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user edit a text with blank content
  patch '/tasks/:id' do
    if !params[:description].empty? && !params[:amount].empty? && !params[:date].empty?
      @task = Task.find(params[:id])
      @task.update(description:params[:description], amount:params[:amount], date:params[:date])
      @log = current_user.logs.find_by(name:params[:log_name])
      @task.log_id = @log.id
      @task.save
      flash[:message] = "Your task Has Been Succesfully Updated"
      redirect_to_home_page
    else
      flash[:message] = "Please Don't Leave Blank Content"
      redirect to "/tasks/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own task if they are logged in
  # does not let a user delete a task they did not create
  delete '/tasks/:id/delete' do
    if logged_in?
      @task = Task.find(params[:id])
      if @task.user_id == current_user.id
        @task.delete
        flash[:message] = "Your task has been deleted successfully"
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end
end
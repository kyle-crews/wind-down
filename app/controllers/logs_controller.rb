class LogsController < ApplicationController

    # lets user view task logs if logged in
    get '/logs' do
        if logged_in?
        @logs = current_user.logs.all
        erb :'logs/logs'
        else
            redirect_if_not_logged_in
        end
    end

    # does not let a user create a blank log
    post '/logs' do
        if params[:name].empty?
            flash[:message] = "Please Enter a log Name"
            redirect_to_logs
        else
            @user = current_user
            @log = log.create(name:params[:name], user_id:@user.id)
            redirect_to_logs
        end
    end

    # displays a single log
    get '/logs/:id' do
        if logged_in?
            @log = log.find(params[:id])
            erb :'logs/show_log'
        else
            redirect_if_not_logged_in
        end
    end

    # lets a user view log edit form if they are logged in
    # does not let a user edit a log not created by it self
    get '/logs/:id/edit' do
        if logged_in?
            @log = log.find(params[:id])
        if @log.user_id == current_user.id
            erb :'logs/edit_log'
        else
            redirect_to_logs
        end
        else
            redirect_if_not_logged_in
        end
    end

    # does not let a user edit a log with blank content
    patch '/logs/:id' do
        if !params[:name].empty?
            @log = log.find(params[:id])
            @log.update(name:params[:name])
            flash[:message] = "Your log has been updated successfully"
            redirect_to_logs
        else
            flash[:message] = "Please don't leave blank content"
            redirect to "/logs/#{params[:id]}/edit"
        end
    end

    # lets a user delete their own log if they are logged in
    # does not let a user delete a log they did not create
    delete '/logs/:id/delete' do
        if logged_in?
        if current_user.logs.size == 1
            flash[:message] = "You need at least one log"
            redirect_to_logs
        else
            @log = log.find(params[:id])
            if @log.user_id == current_user.id
            @log.destroy
            flash[:message] = "Your log has been deleted successfully"
            redirect_to_logs
            end
        end
        else
            redirect_if_not_logged_in
        end
    end

    # helper route created to edit tasks when the erb
    # file adds '/logs' to the edit link
    get '/logs/tasks/:id/edit' do
        if logged_in?
            @task = Task.find(params[:id])
            @log = log.find(@task.log_id)
        if @task.user_id == session[:user_id]
            erb :'tasks/edit_task'
        else
            redirect_to_home_page
        end
        else
            redirect_if_not_logged_in
        end
    end
end
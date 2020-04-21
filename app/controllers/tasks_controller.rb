class TasksController < ApplicationController
    get '/tasks' do
        erb :tasks
    end
end
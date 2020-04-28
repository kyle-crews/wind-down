class LogsController < ApplicationController
    get '/logs' do
        erb :'logs/logs'
    end
end
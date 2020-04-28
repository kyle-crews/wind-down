class LogsController < ApplicationController
    get '/logs' do
        erb :logs
    end
end
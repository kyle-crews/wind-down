class User < ActiveRecord::Base
    has_many :tasks
    has_many :logs
    has_secure_password
end
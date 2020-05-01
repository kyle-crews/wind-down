class User < ActiveRecord::Base
    include Quantifiable::InstanceMethods

    has_many :tasks
    has_many :logs
    has_secure_password

    def logs_sort_by_entry
        self.logs.all.sort_by {|log| log[:entry]}
    end
end
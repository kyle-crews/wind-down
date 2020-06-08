class User < ActiveRecord::Base

  include Quantifiable::InstanceMethods

  has_secure_password

  has_many :days, :dependent => :destroy
  has_many :expenses

  def days_sort_by_name
    self.days.all.sort_by {|day| day[:name]}
  end

end

class Quantifiable

  module InstanceMethods

    def total_amount
      self.logs.collect {|log| log.amount}.sum
    end

    def logs_sort_by_date
      self.logs.sort_by {|log| log[:date]}.reverse
    end
  end

end

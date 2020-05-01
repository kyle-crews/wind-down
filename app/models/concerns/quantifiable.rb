class Quantifiable

    module InstanceMethods
  
      def total_amount
        self.tasks.collect {|task| task.amount}.sum
      end
  
      def tasks_sort_by_date
        self.tasks.sort_by {|task| task[:date]}.reverse
      end
    end
  
end
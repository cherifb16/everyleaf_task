class Task < ApplicationRecord
    validates :name,    length: { in: 1..140 }
    validates :name,:details,:state,:priority,:end_date,presence: true
    paginates_per 3
    belongs_to :user
    def self.search(term,term1)
        if term
          where('name LIKE ?', "%#{term}%")
        elsif term1
          where('name LIKE ?', "%#{term1}%")
        else
          order('created_at desc')
        end
    end
    
    def self.order_list(sort_order)
        if sort_order == "name"
          order(name: :desc)
        elsif sort_order == "end_date"
          order(end_date: :desc)
        elsif sort_order == "priority"
          order(priority: :asc)
        else
          order(created_at: :desc)
        end
    end
    
end

    

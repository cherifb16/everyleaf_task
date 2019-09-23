class Task < ApplicationRecord
    validates :name,    length: { in: 1..140 }
    validates :name,:details,:state,:priority,:end_date,presence: true
    paginates_per 3
    def self.search(term)
        if term
          where('name LIKE ?', "%#{term}%")
        else
          order('id desc')
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

    

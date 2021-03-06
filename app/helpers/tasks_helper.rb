module TasksHelper
    def sortable(name, column, direction)
        direction = sort_direction == "asc" ? "desc" : "asc"
        icon = sort_direction == 'desc' ? 'down' : 'up'
    
        link_to tasks_path, class: 'tiny button secondary', id: column do
          "#{name} &nbsp; <i class=fi-arrow-#{icon}></i>".html_safe
        end
      end
end

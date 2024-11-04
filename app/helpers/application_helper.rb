module ApplicationHelper
  def flash_class(type)
    base_class = ['mb-4 px-4 py-3 rounded-lg border']
    color = case type
    when 'notice'
      color = 'blue'
    when 'success'
      color = 'green'
    when 'alert'
      color = 'yellow'
    when 'error'
      color = 'red'
    else
      color = 'gray'
    end

    base_class << "bg-#{color}-100 text-#{color}-800 border-#{color}-400"

    base_class.join(' ')
  end
end

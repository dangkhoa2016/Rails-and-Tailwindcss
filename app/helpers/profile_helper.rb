module ProfileHelper
  def short_name(full_name = nil)
    return 'Avatar' if full_name.nil? || full_name.strip.empty?  # Return empty string for nil or empty input
    
    # Split the full name into parts by spaces
    name_parts = full_name.split
    
    # Take the first letter of each part, convert to uppercase, and join them
    short_name = name_parts.map { |part| part[0].upcase }.join
    
    short_name
  end
end

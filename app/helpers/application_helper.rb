module ApplicationHelper
    
  # Removing +0900 time
  def simple_time(time)
    time.strftime("%Y-%m-%d　%H:%M　")
  end 

  # Return title for each page
  def full_title(page_title = '')                     # Definite method and option number
    base_title = "KOYAGRAM"  # Set base_title valiable
    if page_title.empty?                              # Empty test
      base_title                                      # Return
    else 
      page_title + " | " + base_title                 # Connect 
    end
  end
end

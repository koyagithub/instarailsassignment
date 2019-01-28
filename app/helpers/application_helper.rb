module ApplicationHelper
    
  #Removing +0900 timezone
  def simple_time(time)
    time.strftime("%Y-%m-%d　%H:%M　")
  end 
end

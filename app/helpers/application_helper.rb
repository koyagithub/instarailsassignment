module ApplicationHelper
    
  #Removing +0900 time
  def simple_time(time)
    time.strftime("%Y-%m-%d　%H:%M　")
  end 
end

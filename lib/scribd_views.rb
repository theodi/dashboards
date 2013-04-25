require 'rscribd'

class ScribdViews 
  
  def self.update
    Scribd::API.instance.key = ENV['SCRIBD_KEY']
    Scribd::API.instance.secret = ENV['SCRIBD_SECRET']
    
    user = Scribd::User.login ENV['SCRIBD_USERNAME'], ENV['SCRIBD_PASSWORD']
    
    count = 0
    
    user.documents.each do |doc|
      count += doc.reads.to_i
    end
    
    { current: count }
  end
  
end
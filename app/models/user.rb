class User < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.from_omniauth(auth)  
    find_by_uid(auth["uid"]) || create_with_omniauth(auth)  
  end  
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["info"]["name"]  
    end  
  end 
end

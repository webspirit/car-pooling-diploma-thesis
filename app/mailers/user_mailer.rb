class UserMailer < ActionMailer::Base
  default from: "carpooling@diplomathesis.com"
  
  def claimed_route(claimed_user, route_user)
    @user = claimed_user
    mail(to: route_user.email, subject: "Car Pooling - Somebody claimed your route!")
  end
  
  def deleted_route(user, route)
    @user = user
    @route = route
    mail(to: user.email, subject: "Car Pooling - Your claimed route has been deleted")
  end
  
  def reminder(user1, user2)
      
  end
  
end

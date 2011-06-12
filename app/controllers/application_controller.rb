class ApplicationController < ActionController::Base  
  protect_from_forgery  
  helper_method :current_user  
    
  private  
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end  
end  
#http://stackoverflow.com/questions/3549713/controller-helper-method
#helper_method is useful when the functionality is something that's used between both the controller and the view. A good example is something like current_user.

#If the method deals more with controller logic and not formatting then it belongs in the controller. Something like current_user would be shared between all controllers so it should be defined in the ApplicationController.

#True "helper" methods deal with the view and handle things like formatting and template logic. These are seldom needed in the controller and they belong in their own module under app/helpers. You can include these in your controller when needed, but you end up with the whole module worth of view helper methods available to your controller.


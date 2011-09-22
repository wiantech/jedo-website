# To change this template, choose Tools | Templates
# and open the template in the editor.

class CustomFailure < Devise::FailureApp

  def initialize
    
  end
  def redirect_url
    new_user_session_url(:subdomain => 'secure')
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      store_location!
      flash[:alert] = i18n_message unless flash[:notice]
      redirect_to root_path 
    end
  end

end

class PasswordsController < Devise::PasswordsController
prepend_before_filter :require_no_authentication
layout "home" 

def new
  super
end

# POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    if resource.errors.empty?
      flash[:notice]="You will receive an email with instructions about how to reset your password in a few minutes."
     # redirect_to new_password_path(resource_name)
      redirect_to new_password_path(resource_name)
    else
      flash[:notice]="Enter your valid email address."
      redirect_to new_password_path(resource_name)
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
    render_with_scope :edit
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(params[resource_name])
    if resource.errors.empty?
      flash[:notice]="Your password was changed successfully.You can signed in now."
      redirect_to root_path
         
    else
      respond_with_navigational(resource){ render_with_scope :edit }
    end
  end
end

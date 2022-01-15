class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @user = User.from_omniauth(request.env['omniauth.auth'])
        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
          sign_in_and_redirect @user, event: :authentication
        else
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end
  end

  
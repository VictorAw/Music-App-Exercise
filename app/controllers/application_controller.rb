class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	
	def current_user
		@user ||= User.find_by_session_token(session[:session_token])
	end

	def login(user)
		# Give session token to the user's browser
		# through the cookie. Key will be invalidated
		# logout	
		session[:session_token] = user.session_token
	end

	def logout(user)
		# Invalidate the old token
		user.reset_session_token!
		# Unset the browser's saved token so that they aren't
		# accidentally bound to someone else's token
		session[:session_token] = nil
	end

	def logged_in?
		!current_user.nil?
	end
end

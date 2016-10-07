class SessionsController < ApplicationController
	def new
		render :new
	end

	def create
		# Find the user
		user = User.find_by_credentials(session_params[:username], session_params[:password])

		# If they are found, give token to cookie
		# Else redirect back to login
		if user
			# Log in
			login(user)
			redirect_to user_url(user)
		else
			# Render does not reroute the url, so we should have a redirect_to
			# render :new
			redirect_to new_session_url
		end

	end

	def destroy
		if current_user
			logout(current_user)
		end
		redirect_to new_session_url
	end

	private
	def session_params
		params.require(:session).permit(:username, :password)
	end
end

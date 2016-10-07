class UsersController < ApplicationController
	def new
		render :new
	end

	def create
		user = User.new(users_params)
		if user.save
			login(user)	
			redirect_to user_url(user)
		else
			redirect_to new_user_url
		end
	end

	def show
		@user = User.find(current_user.id)

		render :show
	end

	private
	def users_params
		params.require(:user).permit(:username, :password, :email)
	end
end

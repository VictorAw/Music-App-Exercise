class TracksController < ApplicationController
	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def show
	end

	def destroy
	end

	private
	def track_params
		params.require(:track).permit(:album_id, :name, :track_type, :lyrics)
	end
end

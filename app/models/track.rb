class Track < ActiveRecord::Base
	TRACK_TYPES = %w(regular bonus)
	
	validates :album_id, :name, :lyrics, presence: true
	validates :track_type, presence: true, inclusion: { in: TRACK_TYPES }
	
	belongs_to :album
end

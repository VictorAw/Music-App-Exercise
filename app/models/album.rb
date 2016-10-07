class Album < ActiveRecord::Base
	RECORDING_TYPES = %w(studio live)

	validates :band_id, :name, presence: true
	validates :recording_type, presence: true, inclusion: { in: RECORDING_TYPES }

	belongs_to :band
	has_many :tracks, dependent: :destroy
end

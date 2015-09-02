class Discussion
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Slug



	field :title
	field :shown, type: Boolean, default: true
	field :proposal_enabled, type: Boolean, default: false
	slug  :title, :history => true
	has_many :tags
	index({ starred: 1 })
end

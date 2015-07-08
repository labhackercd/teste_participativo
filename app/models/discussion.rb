class Discussion
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Slug



	field :title
	field :proposal_enabled, type: Boolean, default: false
	slug  :title, :history => true
	has_many :opinions
	index({ starred: 1 })
end

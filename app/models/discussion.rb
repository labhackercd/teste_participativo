class Discussion
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Slug



	field :title
	slug  :title, :history => true
	embeds_many :opinions
	index({ starred: 1 })
end

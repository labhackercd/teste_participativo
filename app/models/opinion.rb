class Opinion 
	include Mongoid::Document
  	include Mongoid::Timestamps
	
	field :body, type: String
	belongs_to :discussion
  belongs_to :user
	index({ starred: 1 })

	has_many :related_opinions, :class_name => 'Opinion',  :inverse_of => :parent_opinion
  belongs_to :parent_opinion, :class_name => 'Opinion', :inverse_of => :related_opinions
  field :parent_position

	validates :body, presence: true, :if => Proc.new {|opinion| opinion.parent_position == "proposal"}

end

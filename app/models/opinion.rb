class Opinion 
	include Mongoid::Document
	include Mongoid::Timestamps



	field :body, type: String
	field :stub, type: Boolean


  belongs_to :user
	belongs_to :discussion
	index({ starred: 1 })

	has_many :children, :class_name => 'Opinion',  :inverse_of => :parent_opinion
  belongs_to :parent_opinion, :class_name => 'Opinion', :inverse_of => :children
  field :parent_position




	def absolute_relevancy
		relevancy = 0
		self.children.each do |opinion_relevancy|
			relevancy_time_in_days = (((Time.now - opinion_relevancy.created_at))/86400)
			relevancy = relevancy + (1+(10/(Math::E**(relevancy_time_in_days*0.12))))
		end

		return relevancy

	end

end

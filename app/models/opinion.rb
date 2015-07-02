class Opinion 
	include Mongoid::Document
  	include Mongoid::Timestamps
	
	field :body, type: String
	embedded_in :discussion
	index({ starred: 1 })

	embeds_many :opinions_agreeed, :class_name => 'Opinion'
end

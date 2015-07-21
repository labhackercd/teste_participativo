module DiscussionsHelper


  def relevancy_numbers(id, position)
    return Opinion.where(parent_opinion_id: id, parent_position: position).count
  end
end
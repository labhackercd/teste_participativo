module OpinionsHelper

  def relevancy_numbers(id, position)
    return Opinion.where(parent_opinion_id: id, parent_position: position).count
  end

  def users_who_interacted(id)
    return Opinion.find(id).children.collect{|opinion| opinion.user}.uniq
  end

  def position_by_user(id, user)
    return Opinion.find(id).children.collect{|opinion| opinion.parent_position if (opinion.user==user)}.compact
  end

  def stub
    return Opinion.find_or_create_by(:stub => "true")
  end
end
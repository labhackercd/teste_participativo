module DiscussionsHelper


  def childrens (opinion)

    if opinion.related_opinion != nil
      return opinion.related_opinion
    else
      return
    end

  end

  def relevancy_numbers(id, position)

    return Opinion.where(parent_opinion_id: id, parent_position: position).count
  end
end
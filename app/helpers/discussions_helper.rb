module DiscussionsHelper

  def color_by_agreement(position)

      case position

        when "pro"
          return "light-green lighten-4"
        when  "against"
          # TODO Extract Color
          return "red lighten-4"

        when "proposal"
          return "amber lighten-4"

        when nil
          return "light-blue accent-1"

      end
  end

  def relevancy_numbers(id, position)

    return Opinion.where(parent_opinion_id: id, parent_position: position).count
  end
end
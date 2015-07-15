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
end
class DiscussionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_discussion, only: [:show, :create, :layout]



  def layout

  end


  def index
    @discussion = Discussion.all
  end
  # GET /discussions/1
  def show

    gon.root = @discussion.opinions.where(:parent_id == nil).first.id

    gon.discussion_id= @discussion.id


    # @node =
    # @visited = []
    # @edge_to = {}
    #
    # dfs(@discussion.opinions.where(:parent_id == nil).first)
    #
    # @opinions = @visited

  end

  def new
  @discussion = Discussion.new
  end

  def create
   @discussion = Discussion.create(discussion_params)
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find  params[:id]
      @root = @discussion.opinions.where(:parent_opinion_id == nil).first
    end

    # Only allow a trusted parameter "white list" through.
    def discussion_params
      params.require(:discussion).permit(:title, :proposal_enabled)
    end


    def dfs(node)
      @visited << node
      node.related_opinions.each do |adj_node|
        next if @visited.include?(adj_node)
        dfs(adj_node)
        @edge_to[adj_node] = node
      end
    end
end

class DiscussionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_discussion, only: [:show, :create, :layout]



  def index

    hash = {}
    Opinion.all.not.where(:body => nil).each do |opinion|
      hash[opinion] = opinion.absolute_relevancy()
    end

    @opinions = hash.sort_by {|_key, value| value}.reverse.to_h

  end
  # GET /discussions/1
  def show
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
      @order_by = params[:order_by]
      @root = @discussion.opinions.where(:parent_opinion_id == nil).first
    end

    # Only allow a trusted parameter "white list" through.
    def discussion_params
      params.require(:discussion).permit(:title, :proposal_enabled)
    end
end

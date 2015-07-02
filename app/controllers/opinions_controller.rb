class OpinionsController < ApplicationController
  before_action :set_opinion, only: [:show, :edit]

  # GET /opinions
  def index
    @opinions = Opinion.all
  end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # POST /opinions
  def create
    @discussion = Discussion.find(opinion_params[:discussion_id])
    @opinion = Opinion.new(:body => opinion_params[:body])

    @related_opinion = @discussion.opinions.find(params[:opinion]['related_opinion_id'])

    @opinion.opinions_agreeed << @related_opinion if params[:opinion]['position'] == "pro"

    @discussion.opinions << @opinion
    if @opinion.save

      redirect_to @discussion
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion
      @opinion = Opinion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def opinion_params
       params.require(:opinion).permit(:body, :discussion_id, :position, :related_opinion_id)
    end
end

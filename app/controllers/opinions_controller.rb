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
    @opinion = Opinion.new(:body => opinion_params[:body], :parent_position => opinion_params[:position], :user_id => current_user.id )



    @parent_opinion = Opinion.find(params[:opinion]['related_opinion_id'])


    @discussion.opinions << @opinion

    @parent_opinion.related_opinions << @opinion


    if @opinion.save
      redirect_to @discussion
    else
      redirect_to @discussion, notice: I18n.t("discussion.opinion_blank")
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

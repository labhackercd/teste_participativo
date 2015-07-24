class OpinionsController < ApplicationController
  before_action :set_opinion, only: [:show, :edit]
  before_action :set_parent, only: [:participation]

  include OpinionsHelper
  require 'json'

  def participation

    @opinion = Opinion.find_or_initialize_by(:parent_opinion => @parent_opinion, :user_id => current_user.id)

    # TODO CREATE a ENUM to extract this code out
    case params[:position]

      when 'up'
        position = "pro"

      when "down"
        position = "against"

      when "prop"
        position = "proposal"

    end

    last_position = @opinion.parent_position if not nil
    @opinion.parent_position = position
    @discussion.opinions << @opinion
    @parent_opinion.children << @opinion

  respond_to do |format|
    if(last_position == position)
      if @opinion.delete
        @result = 'deleted'
        format.js { head :ok, result: {pro: relevancy_numbers(@parent_opinion, "pro") , against: relevancy_numbers(@parent_opinion, "against"), proposal: relevancy_numbers(@parent_opinion, "proposal"), status: @result, parent: "#{@parent_opinion.id.to_s}", position: params[:position] }.to_json}
      end
      else
        if @opinion.save
        @result = 'saved'
        format.js { head :ok, result: {pro: relevancy_numbers(@parent_opinion, "pro") , against: relevancy_numbers(@parent_opinion, "against"), proposal: relevancy_numbers(@parent_opinion, "proposal"), status: @result, parent: "#{@parent_opinion.id.to_s}", position: params[:position] }.to_json}
        else
          format.js { head :error, result: {pro: relevancy_numbers(@parent_opinion, "pro") , against: relevancy_numbers(@parent_opinion, "against"), proposal: relevancy_numbers(@parent_opinion, "proposal"), status: @result, parent: "#{@parent_opinion.id.to_s}", position: params[:position] }.to_json}
        end
   end
 end
end
  # GET /opinions
  def index
    @opinions = Opinion.all
  end

  def cancel

  end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # POST /opinions
  def create
    #
    # respond_to do |format|
    # if @opinion.save
    #   if @opinion.parent_position == "proposal"
    #     format.html { redirect_to @discussion, notice: I18n.t("discussion.proposal_created")}
    #     format.js   {render action: 'show', status: 'created', location: @discussion}
    #     else
    #     format.html { redirect_to @discussion, notice: I18n.t("discussion.opinion_created")}
    #     format.js   {render action: 'show', status: 'created', location: @discussion}
    #   end
    # else
    #   format.html {redirect_to @discussion, notice: I18n.t("discussion.proposal_blank")}
    # end
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion
      @opinion = Opinion.find(params[:id])
    end

  def set_parent
    @discussion = Discussion.find(params[:discussion_id])
    @parent_opinion = Opinion.find(params[:opinion_id])

  end



    # Only allow a trusted parameter "white list" through.
    def opinion_params
       params.require(:opinion).permit(:body, :discussion_id, :position, :opinion_id)
    end
end

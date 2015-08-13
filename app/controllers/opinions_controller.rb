class OpinionsController < ApplicationController
  include OpinionsHelper
  require 'json'



  def show

    @discussion = Discussion.find(params[:discussion_id])
    @opinion = Opinion.find(params[:id])
  end

  def participation

    @discussion = Discussion.find(params[:discussion_id])
    @parent_opinion = Opinion.find(params[:opinion_id])

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

      if @opinion.children.empty? # No one has interacted with him
        if @opinion.delete
          @result = 'deleted'
          format.js { head :ok, result: {pro: relevancy_numbers(@parent_opinion, "pro") , against: relevancy_numbers(@parent_opinion, "against"), proposal: relevancy_numbers(@parent_opinion, "proposal"), status: @result, parent: "#{@parent_opinion.id.to_s}", position: params[:position], controller: "participation", opinion: "#{@opinion.id.to_s}" }.to_json}
        end
      else
        @result = 'impossible to delete'
        flash[:error] = I18n.t("discussion.opinion_disabled")
        format.js { head :ok, result: {pro: relevancy_numbers(@parent_opinion, "pro") , against: relevancy_numbers(@parent_opinion, "against"), proposal: relevancy_numbers(@parent_opinion, "proposal"), status: @result, parent: "#{@parent_opinion.id.to_s}", position: params[:position], controller: "participation", opinion: "#{@opinion.id.to_s}" }.to_json}
      end

    else
      if @opinion.save
      @result = 'saved'
      format.js { head :ok, result: {pro: relevancy_numbers(@parent_opinion, "pro") , against: relevancy_numbers(@parent_opinion, "against"), proposal: relevancy_numbers(@parent_opinion, "proposal"), status: @result, parent: "#{@parent_opinion.id.to_s}", position: params[:position], controller: "participation", opinion: "#{@opinion.id.to_s}"  }.to_json}
      else
        format.js { head :error, result: {pro: relevancy_numbers(@parent_opinion, "pro") , against: relevancy_numbers(@parent_opinion, "against"), proposal: relevancy_numbers(@parent_opinion, "proposal"), status: @result, parent: "#{@parent_opinion.id.to_s}", position: params[:position], controller: "participation",  opinion: "#{@opinion.id.to_s}" }.to_json}
      end
   end
 end
end
  # GET /opinions
  def index

    @opinions = Opinion.all
  end


  def update

    @opinion = Opinion.find(params[:opinion]['id'])

    @opinion.body = params[:opinion]['body']

    @opinion.save!

    # Delete Stub
    Opinion.find_by(:discussion_id => nil).delete

    redirect_to discussion_path(@opinion.discussion, :order_by => "history")

  end


  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # POST /opinions
  def create
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion
      @opinion = Opinion.find(params[:id])
    end



    # Only allow a trusted parameter "white list" through.

    def opinion_params
       params.require(:opinion).permit(:body, :discussion_id, :position, :opinion_id)
    end
end

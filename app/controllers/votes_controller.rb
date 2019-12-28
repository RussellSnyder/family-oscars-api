class VotesController < ApplicationController
  before_action :set_nomination
  before_action :set_vote, only: [:show, :destroy]

  # GET /categories/:category_id/nominations/:nomination_id/votes
  def index
    json_response(@nomination.votes)
  end

  # GET /categories/:category_id/nominations/:nomination_id/votes/:id
  def show
    json_response(@vote)
  end

  # POST /categories/:category_id/nominations/:nomination_id/votes
  def create
    @nomination.votes.create!(vote_params)
    json_response(@nomination, :created)
  end

  # DELETE /categories/:category_id/nominations/:nomination_id/votes/:id
  def destroy
    @vote.destroy
    head :no_content
  end

  private

  def vote_params
    params.permit(:created_by, :nomination_id)
  end

  def set_nomination
    @nomination = Nomination.find_by!(id: params[:nomination_id])
  end

  def set_vote
    @vote = Vote.find_by!(id: params[:id])
  end
end

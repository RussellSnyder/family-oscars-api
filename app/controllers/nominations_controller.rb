class NominationsController < ApplicationController
  before_action :set_category
  before_action :set_category_nomination, only: [:show, :update, :destroy]

  # GET /categories/:category_id/nominations
  def index
    json_response(@category.nominations)
  end

  # GET /categories/:category_id/nominations/:id
  def show
    json_response(@nomination)
  end

  # POST /categories/:category_id/nominations
  def create
    @category.nominations.create!(nomination_params)
    json_response(@category, :created)
  end

  # PUT /categories/:category_id/nominations/:id
  def update
    @nomination.update(nomination_params)
    head :no_content
  end

  # DELETE /categories/:category_id/nominations/:id
  def destroy
    @nomination.destroy
    head :no_content
  end

  private

  def nomination_params
    params.permit(:title, :created_by, :description)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_category_nomination
    @nomination = @category.nominations.find_by!(id: params[:id]) if @category
  end
end

# frozen_string_literal: true

class PlacesController < ApplicationController
  def show
    render json: PlaceService.fetch_place(params[:id])
  end
end

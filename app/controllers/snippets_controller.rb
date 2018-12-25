class SnippetsController < ApplicationController
  def show
    temp_path = params[:temporary_path]
    relative_path = params[:current_path].present? ? params[:current_path] : ""
    @current_path = "/#{temp_path}/#{URI.unescape(relative_path)}"
  end

  def edit
  end
end

class SnippetsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    temp_path = params[:temporary_path]
    relative_path = params[:current_path].present? ? params[:current_path] : ""
    @current_path = "/#{temp_path}/#{URI.unescape(relative_path)}"
    @extension = @current_path.split(".").last.to_s
  end

  def create 
    file_path   = params[:file_path]
    source_code = params[:source_code]

    File.write(file_path, source_code)
    paths = file_path.split('/')

    redirect_to snippet_path(paths[1..2].join("/"),
        current_path: paths[3..-1].join("/"))
  end
  

  def edit
  end
end

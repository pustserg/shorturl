class UrlsController < ApplicationController
  before_action :link, only: %i(show stats)

  def create
    link = CreateLink.new(params.require(:url).permit(:url)).call
    if link
      render json: { short_url: "#{request.base_url}/#{link.shortened_url}" }
    else
      head :unprocessable_entity
    end
  end

  def show
    if @link
      @link.update!(counter: @link.counter + 1)
      render json: { url: link.url }
    else
      head :not_found
    end
  end

  def stats
    if @link
      render json: { counter: @link.counter }
    else
      head :not_found
    end
  end

  private

  def link
    @link ||= Link.find_by(shortened_url: params[:short_url])
  end
end

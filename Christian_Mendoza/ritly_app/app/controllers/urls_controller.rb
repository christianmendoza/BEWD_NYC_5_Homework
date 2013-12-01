class UrlsController < ApplicationController
  def redirectors
    url =  Url.find_by hash_code: params[:code]
    # God awful. Will be put in a model with validations added!
    redirect_to "http://#{url.link}"
  end

  def preview
    @url = Url.find_by hash_code: params[:code]
    render :show
  end

  def create
    @url = Url.create link: params[:url], hash_code: SecureRandom.urlsafe_base64(8)
    redirect_to @url
  end

  def show
    @url = Url.find params[:id]
  end
end

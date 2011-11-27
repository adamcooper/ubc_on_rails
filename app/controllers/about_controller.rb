class AboutController < ApplicationController

  def about

  end

  def download
    if session[:has_rated]
      send_file(Rails.root.join('secure_assets', 'ubc_on_rails.pdf'))
    else
      redirect_to root_url, flash: {error: "Please add a rating before downloading the presentation"}
    end
  end

end

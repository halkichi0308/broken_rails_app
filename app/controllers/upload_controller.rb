class UploadController < ApplicationController
  def index
  end

  def new
    upload_file = fileupload_param[:file]
    upload_path = Rails.root.join('app/assets/images', upload_file.original_filename)
    #comment for public case Rails.root.join('pubic'

    File.open(upload_path, 'w+b') do |file|
      file.write upload_file.read
    end

    flash[:notice] = 'upload seccess'
    redirect_to '/upload/index'
  end

  def delete
  end

  private
    def fileupload_param
      params.require(:fileupload).permit(:file)
    end
end

class UploadController < ApplicationController
  def index
  end

  def create
    upload_file = fileupload_param[:file]
    upload_path = Rails.root.join('app/assets/images', upload_file.original_filename)
    #comment for public case Rails.root.join('pubic'

    File.open(upload_path, 'w+b') do |file|
      file.write upload_file.read
    end

    redirect_to upload_path, notice: 'upload success'
  end

  def delete
  end

  private
    def fileupload_param
      params.require(:fileupload).permit(:file)
    end
end

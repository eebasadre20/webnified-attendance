class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  before_filter :set_access_control_headers

  def set_access_control_headers
    logger.info request.headers['Origin']
    headers['Access-Control-Allow-Origin'] = request.headers['Origin']
    headers['Access-Control-Allow-Methods'] = 'POST,GET,OPTIONS, PUT, DELETE'
    headers['Access-Control-Request-Method'] = '*'    
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Max-Age'] = '1728000'

  end

  def options
    head :status => 200, :'Access-Control-Allow-Headers' => 'Origin, Authorization, Accept, Content-Type'
  end

  protected
=begin
 def split_base64(uri_str)
    if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
      uri = Hash.new
      uri[:type] = $1 # "image/gif"
      uri[:encoder] = $2 # "base64"
      uri[:data] = $3 # data string
      uri[:extension] = $1.split('/')[1] # "gif"
      return uri
    else
      return nil
    end
  end

  def convert_data_uri_to_upload(obj_hash)
    if obj_hash[:remote_image_url].try(:match, %r{^data:(.*?);(.*?),(.*)$})
      image_data = split_base64(obj_hash[:remote_image_url])
      image_data_string = image_data[:data]
      image_data_binary = Base64.decode64(image_data_string)

      temp_img_file = Tempfile.new("data_uri-upload")
      temp_img_file.binmode
      temp_img_file << image_data_binary
      temp_img_file.rewind

      img_params = {:filename => "data-uri-img.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}
      uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

      obj_hash[:image] = uploaded_file
      obj_hash.delete(:remote_image_url)
    end

    return obj_hash    
  end
=end  
end

require 'open3'

def clearsign(message)
  signed, status = Open3.capture2(GPG_ENV,
                                  'gpg --clearsign --output -',
                                  stdin_data: message)

  fail 'Failed to clearsign message.' unless status.success?

  signed
end

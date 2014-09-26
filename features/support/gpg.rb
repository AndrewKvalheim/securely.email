require 'open3'

def clearsign(message, fingerprint = nil)
  fingerprint ||= FactoryGirl.build(:identity).fingerprint

  signed, status = Open3.capture2(
    GPG_ENV,
    'gpg',
    '--local-user', fingerprint,
    '--clearsign',
    '--output', '-',
    stdin_data: message
  )

  fail 'Failed to clearsign message.' unless status.success?

  signed
end

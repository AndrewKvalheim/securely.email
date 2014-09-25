gnupghome = (Rails.root + '.gnupg').to_s

GPG_ENV = { 'GNUPGHOME' => gnupghome }
GPGME::Engine.home_dir = gnupghome

File.write('./client_secrets.json', ENV["GOOGLE_CLOUD_CREDENTIALS"])

File.write('./credential.json', ENV["TRANSLATION_CREDENTIALS"])

File.write('public/youtube-credentials.yaml', ENV['YAML_CREDENTIALS'])
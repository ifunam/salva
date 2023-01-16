# ::SecureHeaders::Configuration.configure do |config|
#   config.hsts = "max-age=#{20.years.to_i}; includeSubdomains"
#   config.x_frame_options = 'DENY'
#   config.x_content_type_options = "nosniff"
#   config.x_xss_protection = '1; mode=block'
#   config.csp = {
#     script_src: ["'OPT_OUT'"],
#     default_src: ["'https://*'", "'self'"],
#     :frame_src => ["'https://*'", "'http://*.twimg.com'", "'http://itunes.apple.com'"],
#     :img_src => ["'https://*'"],
#     :report_uri => ["'//example.com/uri-directive'"]
#   }
# end

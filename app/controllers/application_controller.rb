class ApplicationController < ActionController::Base
  protect_from_forgery
  
   def log_call
     log = UserLog.new
     log.ip = request.remote_ip
     log.route = request.path
     log.save
   end
  
end

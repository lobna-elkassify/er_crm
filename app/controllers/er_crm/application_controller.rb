class ErCrm::ApplicationController < ApplicationController  
  #uncoment the line below if the engine is running as a standalone app
  #helper TestHelper
  before_filter :authenticate_user!
end

class ErCrm::ApplicationController < ApplicationController
  if User.table_exists?
    before_filter :authenticate_user!
  end
end

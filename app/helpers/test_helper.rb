module TestHelper
  def current_user; User.all.first; end
  def user_personal_information_path; "/"; end
  def destroy_user_session_path; "/"; end
end

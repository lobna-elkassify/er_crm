class Devise
  def self.email_regexp
    /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  end
end
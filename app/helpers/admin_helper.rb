module AdminHelper
  def user_selection
    [nil] + User.all.map do |user|
      [user.email, user.id]
    end
  end
end

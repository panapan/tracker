module UsersHelper

  # Save user into the cookies, nil to forget
  def current_user=(user)
    token = new_token
    if user.nil?
      current_user.update_attribute(:remember_token, encrypt(token))
      cookies.delete(:remember_token)
    else
      cookies.permanent[:remember_token] = token
      user.update_attribute(:remember_token, encrypt(token))
    end
    @current_user = user
  end

  # Restore user from cookies, nil if was not saved
  def current_user
    if @current_user.nil?
      token = encrypt(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: token) 
    else
      @current_user
    end
  end

  def current_or_new
    user = current_user
    user ||=  User.new()
  end

  def anonymous?
    current_user.nil? || current_user.email.nil? || current_user.email.empty?
  end

  def recovery_token(user)
    token = new_token
    user.update_attribute(:remember_token, encrypt(token))
    user.update_attribute(:recovery_time, Time.now())
    token
  end

  def user_by_token(token)
    User.find_by(remember_token: encrypt(token))
  end

  def parcels_cnt
    current_user.nil? ? 0 : current_user.parcels.count()
  end

  def pluralize_ru(cnt, c1, c2_4, c5_0)
    right_digit = cnt.to_s[-1].to_i
    c = c5_0
    c = c2_4 if right_digit < 5 && right_digit > 1
    c = c1 if right_digit == 1
    "#{cnt} #{c}"
  end
 
   private

    def new_token
      SecureRandom.urlsafe_base64
    end

    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

end

class EmailValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def validate(record)
    unless record.email.match(VALID_EMAIL_REGEX)
      record.errors[:base] << "Email doesn't match"
    end
  end
end
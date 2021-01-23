class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
  belongs_to :profile, polymorphic: true
  has_one_attached :avatar

  after_create :set_title_by_gender

  def set_title_by_gender
  	title ||= 	case gender
			  	when 0
			  		I18n.t('general.title.male')
			  	when 1
			  		I18n.t('general.title.female_unknown')
			  	else
			  		I18n.t('general.title.unspecified')
			  	end
  end

  def gender_string
  	case gender
  	when 0
  		I18n.t('general.gender.male')
  	when 1
  		I18n.t('general.gender.female')
  	else
  		I18n.t('general.gender.unspecified')
  	end
  end

  def male?
    gender == 0
  end

  def female?
    gender == 1
  end

  def gender_unspecified?
    !gender.in? [0, 1]
  end

  def gender_not?(gender_attr)
    case gender_attr
    when :male
      gender != 0
    when :female
      gender != 1
    when :unspecified
      gender.in? [0, 1] 
    else
      raise ArgumentError.new "The gender attribute ”#{ gender_attr }” has to be either ”male”, ”female” or ”unspecified”."
    end
  end

  def formatted_phone
    return "" if phone.nil?
    if phone[0..2] == "021" # Group xxx xxx xxxx
      "#{ phone[0..2] } #{ phone[3..5] } #{ phone[6..9] }"
    else # Group xxxx xxx xxx
      "#{ phone[0..3] } #{ phone[4..6] } #{ phone[7..9] }"
    end      
  end

  def name
    "#{ first_name } #{ last_name }"
  end

  alias full_name name

  def active_for_authentication?
    super and active
  end

end

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

  def name
    "#{ first_name } #{ last_name }"
  end

  alias full_name name

  def active_for_authentication?
    super and active
  end

end

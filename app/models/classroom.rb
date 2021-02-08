class Classroom < ApplicationRecord
  belongs_to :form_tutor, class_name: :Staff, foreign_key: :form_tutor_id, optional: true
  belongs_to :school
  has_many :form_students, class_name: :Student, foreign_key: :form
  has_and_belongs_to_many :staffs
  has_and_belongs_to_many :students
  after_create :generate_registration_code
  has_many :observations, as: :observationable

  def generate_registration_code
    self.update! registration_code: Passgen.generate
  end

  def human_color
    case color
    when 'primary' then I18n.t('general.colors.primary').titleize
    when 'info' then I18n.t('general.colors.info').titleize
    when 'danger' then I18n.t('general.colors.danger').titleize
    when 'success' then I18n.t('general.colors.success').titleize
    when 'warning' then I18n.t('general.colors.warning').titleize  
    when 'indigo' then I18n.t('general.colors.indigo').titleize
    when 'purple' then I18n.t('general.colors.purple').titleize
    when 'pink' then I18n.t('general.colors.pink').titleize
    when 'yellow' then I18n.t('general.colors.yellow').titleize
    when 'cyan' then I18n.t('general.colors.cyan').titleize
    end
  end
end
class Subject < ApplicationRecord
	has_many :activities

	def evaluation_human
		case evaluation
    when 0 then I18n.t('subjects.evaluations.none') 
    when 1 then I18n.t('subjects.evaluations.grades_romanian')
    when 2 then I18n.t('subjects.evaluations.letters')
    when 3 then I18n.t('subjects.evaluations.qualificatives_romanian')
    when 4 then I18n.t('subjects.evaluations.percentages')
    end
	end

  def fa_icon
    "far fa-" + icon.sub('_', '-')
  end

  def html_color
    "var(--#{ color })"
  end
end

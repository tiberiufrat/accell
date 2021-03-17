class Subject < ApplicationRecord
	has_many :activities, dependent: :destroy

  def hex_color
    case color
    when 'primary' then '#5e72e4'
    when 'info' then '#11cdef'
    when 'danger' then '#f5365c'
    when 'success' then '#2dce89'
    when 'warning' then '#fb6340' 
    when 'indigo' then '#5603ad'
    when 'purple' then '#8965e0'
    when 'pink' then '#f3a4b5'
    when 'yellow' then '#ffd600'
    when 'cyan' then '#2bffc6'
    end
  end

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

  def dash_icon
    icon.sub('_', '-')
  end

  def html_color
    "var(--#{ color })"
  end
end

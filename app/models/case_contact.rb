class CaseContact < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :casa_case

  CONTACT_TYPES = %w[
    youth
    school
    social_worker
    therapist
    attorney
    bio_parent
    foster_parent
    other_family
    supervisor
    court
    other
  ].freeze
  enum contact_type: CONTACT_TYPES.zip(CONTACT_TYPES).to_h

  def humanized_type
    "#{contact_type.humanize.titleize}#{ " - " + other_type_text if use_other_type_text?}"
  end

  def use_other_type_text?
    contact_type == 'other'
  end
end

# == Schema Information
#
# Table name: case_contacts
#
#  id               :bigint           not null, primary key
#  contact_type     :string           not null
#  duration_minutes :integer          not null
#  occurred_at      :datetime         not null
#  other_type_text  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  casa_case_id     :bigint           not null
#  creator_id       :bigint           not null
#
# Indexes
#
#  index_case_contacts_on_casa_case_id  (casa_case_id)
#  index_case_contacts_on_creator_id    (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (casa_case_id => casa_cases.id)
#  fk_rails_...  (creator_id => users.id)
#

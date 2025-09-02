# frozen_string_literal: true

module FinalizationMessages
  MESSAGES = {
    Proposal::State::ACCEPTED   => ->(event_name) { "[#{event_name}][要返事] プロポーザルを採択いたしました" },
    Proposal::State::REJECTED   => ->(event_name) { "[#{event_name}] プロポーザルは不採択となりました" },
    Proposal::State::WAITLISTED => ->(event_name) { "[#{event_name}][要返事] プロポーザルを補選として採択いたしました" }
  }.freeze

  def subject_for(proposal:, type: proposal.state)
    default_builder = ->(_) { 'Invalid final proposal type' }
    subject_builder = MESSAGES[type] || default_builder
    subject_builder.call(proposal.event.name)
  end
end

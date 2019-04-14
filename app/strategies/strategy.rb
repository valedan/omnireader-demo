# frozen_string_literal: true

class Strategy
  REGISTRY = {
    FFNStrategy: %r{(fictionpress\.com|fanfiction\.net)/s/\d+/}
  }.freeze

  def initialize(url)
    @url = url
  end

  def self.for(url)
    match = REGISTRY.find { |_klass, pattern| pattern.match?(url) }
    match ? match.first.to_s.constantize.new(url) : nil
  end
end

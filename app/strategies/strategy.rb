# frozen_string_literal: true

class Strategy
  def initialize(url)
    @url = url
  end

  @@registrations = []

  def self.register_for(pattern)
    @@registrations << { strategy: name, pattern: pattern }
  end

  def self.for(url)
    @@registrations.find { |registration| registration[:pattern].match?(url) }[:strategy].constantize.new(url)
  end
end

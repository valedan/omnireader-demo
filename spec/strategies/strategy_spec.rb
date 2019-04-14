# frozen_string_literal: true

require 'rails_helper'

describe Strategy, type: :strategy do
  describe '.for' do
    class TestStrategy < Strategy; end
    before { stub_const('Strategy::REGISTRY', TestStrategy: /test/) }

    context 'When a matching strategy is registered' do
      it 'returns the matching strategy class' do
        expect(Strategy.for('someteststring')).to be_an_instance_of(TestStrategy)
      end
    end

    context 'When no matching strategy is registered' do
      it 'returns nil' do
        expect(Strategy.for('differentstring')).to be nil
      end
    end
  end
end

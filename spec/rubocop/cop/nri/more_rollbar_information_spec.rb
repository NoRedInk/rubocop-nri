require 'spec_helper'

RSpec.describe RuboCop::Cop::Nri::MoreRollbarInformation do
  let(:cop) { described_class.new }

  context 'debug' do
    it 'does not check for any hash being sent' do
      source = 'Rollbar.debug'

      inspect_source(cop, source)

      expect(cop.offenses).to be_empty
    end

    it 'does not check for :advisory or :impact' do
      source = 'Rollbar.debug(foo: true)'

      inspect_source(cop, source)

      expect(cop.offenses).to be_empty
    end
  end

  context 'info' do
    it 'does not check for any hash being sent' do
      source = 'Rollbar.info'

      inspect_source(cop, source)

      expect(cop.offenses).to be_empty
    end

    it 'does not check for :advisory or :impact' do
      source = 'Rollbar.info(foo: true)'
      
      inspect_source(cop, source)
      
      expect(cop.offenses).to be_empty
    end
  end

  context 'warning' do
    it 'does not check for any hash being sent' do
      source = 'Rollbar.warning'

      inspect_source(cop, source)

      expect(cop.offenses).to be_empty
    end

    it 'does not check for :advisory or :impact' do
      source = 'Rollbar.warning(foo: true)'

      inspect_source(cop, source)

      expect(cop.offenses).to be_empty
    end
  end

  context 'error' do
    it 'checks for a hash being sent' do
      source = 'Rollbar.error'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1
    end

    it 'checks for :advisory' do
      source = 'Rollbar.error(impact: true)'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1 
    end

    it 'checks for :impact' do
      source = 'Rollbar.error(advisory: true)'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1 
    end

    it 'checks for both :advisory and :impact' do
      source = 'Rollbar.error(foo: true)'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1 
    end

    it 'does not fail if both :advisory and :impact are included' do
      source = 'Rollbar.error(advisory: true, impact: true)'

      inspect_source(cop, source)

      expect(cop.offenses).to be_empty
    end
  end

  context 'critical' do
    it 'checks for a hash being sent' do
      source = 'Rollbar.critical'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1
    end

    it 'checks for :advisory' do
      source = 'Rollbar.critical(impact: true)'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1 
    end

    it 'checks for :impact' do
      source = 'Rollbar.critical(advisory: true)'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1 
    end

    it 'checks for both :advisory and :impact' do
      source = 'Rollbar.critical(foo: true)'

      inspect_source(cop, source)

      expect(cop.offenses.size).to eq 1
    end

    it 'does not fail if both :advisory and :impact are included' do
      source = 'Rollbar.critical(advisory: true, impact: true)'

      inspect_source(cop, source)

      expect(cop.offenses).to be_empty
    end
  end
end

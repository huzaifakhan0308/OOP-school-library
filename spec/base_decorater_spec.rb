require_relative '../base_decorater'

describe BaseDecorater do
  before(:each) do
    @base_decorater = BaseDecorater.new('hello')
  end

  describe '#new' do
    it 'returns a base decorater object' do
      expect(@base_decorater).to be_an_instance_of(BaseDecorater)
    end
  end
end

describe CapitalizeDecorator do
  before(:each) do
    @capitalize_decorator = CapitalizeDecorator.new('hello')
  end

  describe '#new' do
    it 'returns a capitalize decorator object' do
      expect(@capitalize_decorator).to be_an_instance_of(CapitalizeDecorator)
    end
  end
end

describe TrimmerDecorator do
  before(:each) do
    @trimmer_decorator = TrimmerDecorator.new('hello')
  end

  describe '#new' do
    it 'returns a trimmer decorator object' do
      expect(@trimmer_decorator).to be_an_instance_of(TrimmerDecorator)
    end
  end
end

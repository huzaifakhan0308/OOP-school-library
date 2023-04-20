require_relative "../base_decorater"

describe CapitalizeDecorator do

    before(:each) do
        @capitalize_decorator = CapitalizeDecorator.new("hello")
    end
    
    describe '#new' do
        it 'returns a capitalize decorator object' do
        expect(@capitalize_decorator).to be_an_instance_of(CapitalizeDecorator)
        end
    end
end

describe TrimmerDecorator do

    before(:each) do
        @trimmer_decorator = TrimmerDecorator.new("hello")
    end
    
    describe '#new' do
        it 'returns a trimmer decorator object' do
        expect(@trimmer_decorator).to be_an_instance_of(TrimmerDecorator)
        end
    end
end

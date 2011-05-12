require 'spec_helper'

describe DataMapper::Resource do
  describe '#save_or_raise' do
    context 'when valid' do
      it 'returns true' do
        Book.new(:name => 'Test Book').save_or_raise.should be_true
      end
    end

    context 'when invalid' do
      it 'raises errors' do
        lambda do
          book = Book.new.save_or_raise
        end.should raise_error
      end
    end

    context 'contextual validations' do
      context 'when valid' do
        it 'returns true' do
          Book.new(:name => 'Test Book',:author => 'Author').save_or_raise(:published).should be_true
        end
      end

      context 'when invalid' do
        it 'raises errors' do
          lambda do
            Book.new.save_or_raise(:published)
          end.should raise_error
        end
      end
    end
  end

  describe '#update_or_raise' do
    before :each do
      @book = Book.create_or_raise(:name => 'Test Name')
    end
    
    context 'when valid' do
      it 'returns true' do
        @book.update_or_raise(:name => 'Test Name 2').should be_true
      end
    end

    context 'when invalid' do
      it 'raises error' do
        lambda do
          @book.update_or_raise(:name => nil)
        end.should raise_error
      end
    end
  end
end

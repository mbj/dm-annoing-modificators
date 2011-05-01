require 'spec_helper'

describe DataMapper::Resource do
  describe '#save_or_raise' do
    context 'valid' do
      it 'returns true' do
        Book.new(:name => 'Test Book').save.should be_true
      end
    end

    context 'invalid' do
      it 'raises errors' do
        lambda do
          book = Book.new.save_or_raise
        end.should raise_error
      end
    end
  end

  describe '#update_or_raise' do
    before :each do
      @book = Book.create_or_raise(:name => 'Test Name')
    end
    
    context 'valid' do
      it 'returns true' do
        @book.update_or_raise(:name => 'Test Name 2').should be_true
      end
    end

    context 'invalid' do
      it 'raises error' do
        lambda do
          @book.update_or_raise(:name => nil)
        end.should raise_error
      end
    end
  end
end

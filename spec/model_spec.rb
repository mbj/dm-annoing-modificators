require 'spec_helper'

describe DataMapper::Model do
  describe '#create_or_raise' do
    context 'when valid' do
      it 'returns the created resource' do
        book = Book.create_or_raise(:name => 'Test Name')
        book.should be_kind_of Book
        book.name.should == 'Test Name'
        book.should be_saved
      end
    end

    context 'when invalid' do
      it 'raises an exception' do
        lambda do
          Book.create_or_raise()
        end.should raise_error
      end
    end
  end

  describe '#first_or_create_or_raise' do
    context 'when valid' do
      it 'returns the created resource' do
        book = Book.first_or_create_or_raise(:name => 'Test Name')
        book.should be_kind_of Book
        book.name.should == 'Test Name'
        book.should be_saved
      end
    end

    context 'when invalid' do
      it 'raises an exception' do
        lambda do
          book = Book.first_or_create_or_raise(:author => 'Test Name')
        end.should raise_error
      end
    end
  end
end

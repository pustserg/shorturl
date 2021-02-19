require 'rails_helper'

RSpec.describe CreateLink, type: :operation do
  subject { described_class.new(params).call }

  context 'valid params with http' do
    let(:params) do
      { url: 'http://example.com' }
    end

    it 'should create link' do
      expect { subject }.to change(Link, :count).by(1)
    end

    it 'should create correct link' do
      link = subject
      expect(link.url).to eq 'http://example.com'
    end
  end

  context 'valid params with https' do
    let(:params) do
      { url: 'https://example.com' }
    end

    it 'should create link' do
      expect { subject }.to change(Link, :count).by(1)
    end

    it 'should create correct link' do
      link = subject
      expect(link.url).to eq 'https://example.com'
    end
  end

  context 'inavlid params' do
    let(:params) do
      { urls: 'example.com' }
    end

    it 'should not create link' do
      expect { subject }.not_to change(Link, :count)
    end

    it 'should return nil' do
      expect(subject).to be_nil
    end

  end

  context 'invalid url in params' do
    let(:params) do
      { url: 'example.com' }
    end

    it 'should not create link' do
      expect { subject }.not_to change(Link, :count)
    end

    it 'should return nil' do
      expect(subject).to be_nil
    end
  end
end

require 'rails_helper'

RSpec.describe UrlsController, type: :request do
  describe 'POST #create' do
    let(:params) do
      { url: { url: 'http://example.com' } }
    end

    subject { post '/urls', params: params }

    before do
      expect(CreateLink).to receive(:new).and_return(operation)
      subject
    end

    context 'success' do
      let(:link) { build :link }
      let(:operation) { double(call: link) }

      it 'should be success' do
        expect(response).to have_http_status(200)
      end

      it 'should return link' do
        expect(JSON.parse(response.body)).to \
          match('short_url' => "#{request.base_url}/#{link.shortened_url}")
      end
    end

    context 'failure' do
      let(:operation) { double(call: nil) }

      it 'should return 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET #show' do
    context 'success' do
      let!(:link) { create :link }

      subject { get "/urls/#{link.shortened_url}" }

      it 'should be success' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'should return link' do
        subject
        expect(JSON.parse(response.body)).to match('url' => link.url)
      end

      it 'should increment link counter' do
        expect { subject }.to change{ link.reload.counter }.by(1)
      end
    end

    context 'failure' do
      subject { get '/urls/aaa' }

      it 'should not be success' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #stats' do
    context 'success' do
      let!(:link) { create :link, counter: rand(1..100) }

      subject { get "/urls/#{link.shortened_url}/stats" }

      it 'should be success' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'should return link' do
        subject
        expect(JSON.parse(response.body)).to match('counter' => link.counter)
      end
    end

    context 'failure' do
      subject { get '/urls/aaa/stats' }

      it 'should not be success' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end
end

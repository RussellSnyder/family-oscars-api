require 'rails_helper'

RSpec.describe 'Vote API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:category) { create(:category, created_by: user.id) }
  let!(:nomination) { create(:nomination, category_id: category.id, created_by: user.id) }
  let!(:votes) { create_list(:vote, 20, nomination_id: nomination.id, created_by: user.id) }

  let(:category_id) { category.id }
  let(:nomination_id) { nomination.id }
  let(:id) { votes.first.id }
  let(:headers) { valid_headers }

  describe 'GET /categories/:category_id/nominations/:nomination_id/votes' do
    before { get "/categories/#{category_id}/nominations/#{nomination_id}/votes", params: {}, headers: headers }

    context 'when nomination exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all nomination votes' do
        expect(json.size).to eq(20)
      end
    end

    context 'when nomination does not exist' do
      let(:nomination_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find/)
      end
    end
  end

  describe 'GET /categories/:category_id/nominations/:nomination_id/votes/:id' do
    before { get "/categories/#{category_id}/nominations/#{nomination_id}/votes/#{id}", params: {}, headers: headers }

    context 'when vote exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the vote' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when vote does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Vote/)
      end
    end
  end

  describe 'POST /categories/:category_id/nominations/:nomination_id/votes' do
    let(:valid_attributes) { { created_by: user.id, nomination_id: nomination_id }.to_json }

    context 'when request attributes are valid' do
      before { post "/categories/#{category_id}/nominations/#{nomination_id}/votes", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/categories/#{category_id}/nominations/#{nomination_id}/votes", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Created by/)
      end
    end
  end

  describe 'DELETE /categories/:category_id/nominations/:nomination_id/votes/:id' do
    before { delete "/categories/#{category_id}/nominations/#{nomination_id}/votes/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
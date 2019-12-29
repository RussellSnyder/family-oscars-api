require 'rails_helper'

RSpec.describe 'Nomination API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:category) { create(:category, created_by: user.id ) }
  let!(:nominations) { create_list(:nomination, 20, category_id: category.id) }
  let(:category_id) { category.id }
  let(:id) { nominations.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /categories/:category_id/nominations
  describe 'GET /categories/:category_id/nominations' do
    before { get "/categories/#{category_id}/nominations", params: {}, headers: headers }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all category nominations' do
        expect(json.size).to eq(20)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category with 'id'=#{category_id}/)
      end
    end
  end

  # Test suite for GET /categories/:category_id/nominations/:id
  describe 'GET /categories/:category_id/nominations/:id' do
    before { get "/categories/#{category_id}/nominations/#{id}", params: {}, headers: headers }

    context 'when category nomination exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the nomination' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when category nomination does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Nomination/)
      end
    end
  end

  # Test suite for PUT /categories/:category_id/nominations
  describe 'POST /categories/:category_id/nominations' do
    let(:valid_attributes) { { title: 'Visit Narnia', created_by: '2' }.to_json }

    context 'when request attributes are valid' do
      before { post "/categories/#{category_id}/nominations", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/categories/#{category_id}/nominations", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /categories/:category_id/nominations/:id
  describe 'PUT /categories/:category_id/nominations/:id' do
    let(:valid_attributes) { { title: 'Mozart' }.to_json }

    before { put "/categories/#{category_id}/nominations/#{id}", params: valid_attributes, headers: headers }

    context 'when nomination exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the nomination' do
        updated_nomination = Nomination.find(id)
        expect(updated_nomination.title).to match(/Mozart/)
      end
    end

    context 'when the nomination does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find/)
      end
    end
  end

  # Test suite for DELETE /categories/:id
  describe 'DELETE /categories/:id' do
    before { delete "/categories/#{category_id}/nominations/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
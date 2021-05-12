require 'rails_helper'

RSpec.describe CalculadoraController, type: :controller do

  describe "GET #index" do
    it 'render index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET #calcular" do
    subject(:values) do
      {
        :valor_produto => '8500.00', 
        :valor_ipi => '400.00', 
        :valor_frete => '35.00', 
        :valor_seguro => '65.00', 
        :valor_outras_despesas => '1500.00', 
        :valor_descontos => '500.00', 
        :mva => '39.00', 
        :aliquota_operacao => '18.00', 
        :aliquota_interna => '18.00'
      }
    end

    it "returns http success" do
      post :calcular, body: { values: values }.to_json, format: :json
      expect(response).to have_http_status(:success)
    end

    it "returns http bad_request" do
      post :calcular, body: { :invalid => nil }.to_json, format: :json
      expect(response).to have_http_status(:bad_request)
    end

    it "returns valid values" do
      post :calcular, body: { values: values }.to_json, format: :json
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success), json['errors']
      expect(json['base_de_calculo_icms']).to eq('9.600,00')
      expect(json['base_de_calculo_icms_st']).to eq('9.600,00')
      expect(json['valor_icms_operacao']).to eq('9.600,00')
      expect(json['valor_icms_st']).to eq('9.600,00')
    end
  end
end

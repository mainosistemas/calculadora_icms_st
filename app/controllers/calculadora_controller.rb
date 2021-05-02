class CalculadoraController < ApplicationController
  def index
  end

  def calcular
    # BC = (Valor do Produto + Valor do IPI + Frete + Seguro + Outras Despesas Acessórias – Descontos) x (1+ (Margem de Valor Agregado/100)
    valor_produto = params[:valor_produto].to_f
    valor_ipi = params[:valor_ipi].to_f
    valor_frete = params[:valor_frete].to_f
    valor_seguro = params[:valor_seguro].to_f
    valor_outras_despesas = params[:valor_outras_despesas].to_f
    valor_descontos = params[:valor_descontos].to_f
    mva = params[:mva].to_f

    base_de_calculo = (valor_produto + valor_ipi + valor_frete + valor_seguro + valor_outras_despesas - valor_descontos) * (1 + (mva / 100))

    render plain: base_de_calculo
  end
end

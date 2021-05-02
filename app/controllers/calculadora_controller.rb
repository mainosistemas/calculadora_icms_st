# Base de cálculo do ICMS interestadual:
# (Valor do Produto + Frete + Seguro + Outras Despesas Acessórias – Descontos)
#
# Valor do ICMS interestadual:
# (Base de cálculo do ICMS interestadual) * (Alíquota de ICMS interestadual / 100)
#
# Base de cálculo do ICMS ST:
# (Valor do Produto + Valor do IPI + Frete + Seguro + Outras Despesas Acessórias – Descontos) x (1+ (Margem de Valor Agregado/100)
#
# Valor do ICMS ST:
# ((Base de cálculo do ICMS ST) * (Alíquota do ICMS interno / 100)) - Valor do ICMS interestadual
#
# Exemplo de cálculo:
# Valor do produto: 8.500,00
# Valor do IPI: 400,00
# Valor do frete: 35,00
# Valor do seguro: 65,00
# Valor de outras despesas acessórias: 1.500,00
# Valor dos descontos: 500,00
# Margem de Valor Agregado: 39%
# Alíquota do ICMS interestadual: 7%
# Alíquota do ICMS interno: 18%
#
# Resultado:
# Base de cálculo do ICMS interestadual: 9600,00
# Valor do ICMS interestadual: 672,00
# Base de cálculo do ICMS ST: 13.900,00
# Valor do ICMS ST: 1.830,00

class CalculadoraController < ApplicationController
  def index
  end

  def calcular
    valor_produto = params[:valor_produto].to_f
    valor_ipi = params[:valor_ipi].to_f
    valor_frete = params[:valor_frete].to_f
    valor_seguro = params[:valor_seguro].to_f
    valor_outras_despesas = params[:valor_outras_despesas].to_f
    valor_descontos = params[:valor_descontos].to_f
    mva = params[:mva].to_f
    aliquota_operacao = params[:aliquota_operacao].to_f
    aliquota_interna = params[:aliquota_interna].to_f

    @base_de_calculo_icms = valor_produto + valor_frete + valor_seguro + valor_outras_despesas - valor_descontos
    @base_de_calculo_icms_st = (@base_de_calculo_icms + valor_ipi) * (1 + (mva / 100))
    @valor_icms_operacao = @base_de_calculo_icms * (aliquota_operacao / 100)
    @valor_icms_st = @base_de_calculo_icms_st * (aliquota_interna / 100) - @valor_icms_operacao
  end
end

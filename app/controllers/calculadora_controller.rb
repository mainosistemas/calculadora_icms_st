# Base de cálculo do ICMS interestadual:
# (Valor do Produto + Frete + Seguro + Outras Despesas Acessórias – Descontos)
#
# Valor do ICMS interestadual:
# (Base de cálculo do ICMS interestadual) * (Alíquota de ICMS interestadual / 100)
#
# Base de cálculo do ICMS ST:
# (Valor do Produto + Valor do IPI + Frete + Seguro + Outras Despesas Acessórias – Descontos) * (1+ (Margem de Valor Agregado/100)
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
#
# Cálculo da MVA ajustada:
# ((1 + (MVA original / 100)) * (1 - (alíquota da operação / 100)) / (1 - (alíquota do destinatário / 100)) - 1) * 100
#
# Exemplo de MVA ajustada:
# MVA original: 50%
# Alíquota do ICMS interestadual: 7%
# Alíquota do ICMS interno: 18%
#
# Resultado:
# MVA ajustada: 70,12 (arredondar para duas casas decimais)

class CalculadoraController < ApplicationController
  def index
  end

  def calcular
    service = CalculatorService.new(calculador_params)
    if service.success
      respond_to do |format|
        format.json { render json: service.result }
        format.html { render 'calcular.html', locals: service.result }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: service.errors }, status: :bad_request }
        format.html { render '500.html', status: :bad_request }
      end
    end
  end

  private 

    def calculador_params
      params.require(:values).permit(:valor_produto, :valor_ipi, :valor_frete, :valor_seguro, :valor_outras_despesas, :valor_descontos, :mva, :aliquota_operacao, :aliquota_interna)
    end
end

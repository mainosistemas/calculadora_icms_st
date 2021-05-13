class CalculatorService
  include SimpleCommand

  attr_reader :valor_produto, :valor_ipi, :valor_frete, :valor_seguro, :valor_outras_despesas, :valor_descontos, :mva, :aliquota_operacao, :aliquota_interna

  def initialize(calculador_params)
    @valor_produto = calculador_params[:valor_produto].to_f
    @valor_ipi = calculador_params[:valor_ipi].to_f
    @valor_frete = calculador_params[:valor_frete].to_f
    @valor_seguro = calculador_params[:valor_seguro].to_f
    @valor_outras_despesas = calculador_params[:valor_outras_despesas].to_f
    @valor_descontos = calculador_params[:valor_descontos].to_f
    @mva = calculador_params[:mva].to_f
    @aliquota_operacao = calculador_params[:aliquota_operacao].to_f
    @aliquota_interna = calculador_params[:aliquota_interna].to_f
  end

  def call
    execute
  rescue ArgumentError => e
    errors.add(:message => "Failed here: #{e.message}")
  end

  private

    def execute  
      @base_de_calculo_icms = @valor_produto + @valor_frete + @valor_seguro + @valor_outras_despesas - @valor_descontos
      @base_de_calculo_icms_st = (@base_de_calculo_icms + @valor_ipi) * (1 + (@mva / 100))
      @valor_icms_operacao = @base_de_calculo_icms * (@aliquota_operacao / 100)
      @valor_icms_st = @base_de_calculo_icms_st * (@aliquota_interna / 100) - @valor_icms_operacao

      return {
        :base_de_calculo_icms => @base_de_calculo_icms,
        :base_de_calculo_icms_st => @base_de_calculo_icms_st,
        :valor_icms_operacao => @valor_icms_operacao,
        :valor_icms_st => @valor_icms_st
      }
    end
end
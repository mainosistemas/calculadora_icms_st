require "application_system_test_case"

class CalculadoraIcmsStTest < ApplicationSystemTestCase
  test "calcula o ICMS ST sem MVA ajustada (operação interna)" do
    visit "/calculadora"

    fill_in "Valor dos produtos", with: "8500.00"
    fill_in "Valor do IPI", with: "400.00"
    fill_in "Valor do frete", with: "35.00"
    fill_in "Valor do seguro", with: "65.00"
    fill_in "Outras despesas acessórias", with: "1500.00"
    fill_in "Valor dos descontos", with: "500.00"
    fill_in "Margem de Valor Agregado", with: "39.00"
    fill_in "Alíquota de ICMS da operação", with: "18.00"
    fill_in "Alíquota de ICMS do estado do destinatário", with: "18.00"

    click_on "Calcular"

    # Base de cálculo do ICMS
    assert_text "9.600,00"
    # Valor do ICMS interestadual
    assert_text "1.728,00"
    # Base de cálculo do ICMS ST
    assert_text "13.900,00"
    # Valor do ICMS ST
    assert_text "774,00"
  end
end

module TailwindHelper
  def tailwind_campo_em_moeda_com_label(form:, campo:, moeda: "R$", label_tag:)
    render partial: "tailwind/campo_em_moeda_com_label", locals: {
      form: form,
      label_tag: label_tag,
      campo: campo,
      moeda: moeda
    }
  end

  def tailwind_campo_em_percentual_com_label(form:, campo:, label_tag:)
    render partial: "tailwind/campo_em_percentual_com_label", locals: {
      form: form,
      label_tag: label_tag,
      campo: campo
    }
  end
end

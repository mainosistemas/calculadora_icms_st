Rails.application.routes.draw do
  get "calculadora", to: "calculadora#index"
  post "calculadora", to: "calculadora#calcular"
end

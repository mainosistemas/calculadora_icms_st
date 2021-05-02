Rails.application.routes.draw do
  root to: "calculadora#index"
  get "calculadora", to: "calculadora#index"
  post "calculadora", to: "calculadora#calcular"
end
